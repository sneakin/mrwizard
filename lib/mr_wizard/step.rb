module MrWizard
  class Step
    class_inheritable_accessor :title
    attr_reader :wizard
    delegate :params, :controller, :to => :wizard

    def initialize(wizard)
      @wizard = wizard
    end

    def show; true; end
    def update; true; end
    def needed?; true; end

    def name
      view.to_sym
    end

    def view
      prepped_class_name.underscore
    end

    def title
      self.class.title || prepped_class_name.titleize
    end

    private

    def prepped_class_name
      self.class.name.demodulize.gsub(/Step$/, '')
    end
  end
end
