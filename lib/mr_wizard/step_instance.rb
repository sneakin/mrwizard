module MrWizard
  class StepInstance
    attr_reader :definition

    def initialize(wizard, definition)
      @wizard = wizard
      @definition = definition
    end

    def show
      if @definition.show
        @wizard.instance_eval(&@definition.show)
      else
        true
      end
    end

    def update
      if @definition.update
        @wizard.instance_eval(&@definition.update)
      else
        true
      end
    end

    def needed?
      if @definition.needed
        @wizard.instance_eval(&@definition.needed)
      else
        true
      end
    end

    delegate :name, :view, :title, :to => :definition
  end
end
