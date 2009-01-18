module MrWizard
  module Step
    def self.included(base)
      base.extend(ClassMethods)
    end

    module ClassMethods
      def step(step = nil, options = Hash.new)
        @step = step if step
        @wizard = options[:for]
        @step
      end

      def wizard
        @wizard
      end
    end

    def redirect_to_next_step
      redirect_to(wizard_path)
    end

    def wizard_path
      send("#{self.class.wizard}_path", :step => self.class.step)
    end

    def create
      update
    end
  end
end
