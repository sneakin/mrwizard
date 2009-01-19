module MrWizard
  class Base
    class_inheritable_accessor :steps, :url
    attr_reader :step, :controller, :params
    delegate :title, :show, :to => :step

    self.steps = Array.new

    def initialize(step_name, controller)
      @controller = controller

      begin
        @step = create_step(step_name)
      rescue ArgumentError
        @step = create_step(self.class.steps.first || :done)
      end
    end

    class << self
      def find_step(name)
        index = step_index(name)
        self.steps[index] if index
      end

      def step_index(step)
        self.steps.index(step.to_sym) if step
      end
    end

    def update(params)
      @params = params
      @step.update
    end

    def done?
      @step.kind_of? MrWizard::DoneStep
    end

    def url(params = Hash.new)
      controller.send(self.class.url, { :step => @step.name }.merge(params))
    end

    def next_step(step = @step)
      return :done if step.name == :done

      i = self.class.step_index(step.name)
      raise RuntimeError.new("Unknown step: #{step.name}") unless i
      return :done if (i + 1) >= self.class.steps.length
        
      step_inst = create_step(self.class.steps[i + 1])
      return step_inst.name if step_inst.needed?

      next_step(step_inst)
    end

    private

    def step_name(name)
      "#{controller.class.name.gsub(/Controller$/, '')}::#{name.to_s.camelize}Step"
    end

    def create_step(name)
      if name && name.to_sym == :done
        MrWizard::DoneStep.new(self)
      elsif self.class.find_step(name)
        step_name(name).constantize.new(self)
      else
        raise ArgumentError.new("Unknown step: #{name}")
      end
    end
  end
end
