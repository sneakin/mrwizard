module MrWizard
  class StepDefinition
    def self.battr_accessor(*attrs)
      attrs.each { |attr|
        self.class_eval <<-EOT
          def #{attr}(&block)
            @#{attr} = block if block_given?
            @#{attr}
          end
        EOT
      }
    end
    attr_accessor :name, :title, :view
    battr_accessor :show, :update, :needed

    def initialize(name, &block)
      @name = name
      @title = @name.to_s.titleize
      @view = name.to_s.underscore

      yield(self) if block_given?
    end
  end
end
