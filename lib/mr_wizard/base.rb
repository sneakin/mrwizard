module MrWizard
  class Base
    class_inheritable_accessor :steps, :url
    attr_reader :step, :controller

    def initialize(step_name, controller)
      @step = create_step(step_name)
      @controller = controller
    end

    def self.step(name, &block)
      step = StepDefinition.new(name, &block)

      self.steps ||= Array.new
      self.steps << step
    end

    def self.find_step(name)
      self.steps.find { |step| step.name == name.to_sym } if name
    end

    def create_step(name)
      definition = if name == nil
                     self.steps.first
                   elsif name.to_sym == :done
                     DoneStep.new
                   else
                     self.class.find_step(name)
                   end

      StepInstance.new(self, definition)
    end

    def title
      @step.title
    end

    def show
      @step.show
    end

    def update(params)
      @params = params
      @step.update
    end

    def params
      @params
    end

    def next_step(step = @step)
      i = self.class.step_index(step)
      raise RuntimeError.new("Unknown step: #{step.name}") unless i

      if (i + 1) >= self.class.steps.length
        :done
      elsif i >= 0
        step = create_step(self.class.steps[i + 1].name)

        if step.needed?
          step.name
        else
          next_step(step)
        end
      end
    end

    def self.step_index(step)
      self.steps.index(step.definition)
    end

    def done?
      @step.name == :done
    end

    def url(params = Hash.new)
      controller.send(self.class.url, { :step => @step.name }.merge(params))
    end
  end
end
