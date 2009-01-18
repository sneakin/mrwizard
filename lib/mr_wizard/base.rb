module MrWizard
  class Base
    class_inheritable_accessor :steps, :url
    attr_reader :step, :controller

    self.steps = Array.new

    def initialize(step_name, controller)
      @controller = controller

      begin
        @step = create_step(step_name)
      rescue ArgumentError
        @step = create_step(self.class.steps.first)
      end
    end

    def self.find_step(name)
      self.steps.find { |step| step == name.to_sym } if name
    end

    def step_name(name)
      "#{controller.class.name.gsub(/Controller$/, '')}::#{name.to_s.camelize}Step"
    end

    def create_step(name)
      name ||= self.steps.first
      if name == nil || name.to_sym == :done
        MrWizard::DoneStep.new(self)
      elsif self.class.find_step(name)
        step_name(name).constantize.new(self)
      else
        raise ArgumentError.new("Unknown step: #{name}")
      end
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
      return :done if step.name == :done

      i = self.class.step_index(step.name)
      raise RuntimeError.new("Unknown step: #{step.name}") unless i

      if (i + 1) >= self.class.steps.length
        :done
      elsif i >= 0
        step_inst = create_step(self.class.steps[i + 1])

        if step_inst.needed?
          step_inst.name
        else
          next_step(step_inst)
        end
      end
    end

    def self.step_index(step)
      self.steps.index(step.to_sym)
    end

    def done?
      @step.name == :done
    end

    def url(params = Hash.new)
      controller.send(self.class.url, { :step => @step.name }.merge(params))
    end
  end
end
