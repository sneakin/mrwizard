module MrWizard
  class Step
    class_inheritable_accessor :title
    attr_reader :wizard

    def initialize(wizard)
      @wizard = wizard
    end

    delegate :params, :controller, :to => :wizard

    def show
      true
    end

    def update
      true
    end

    def needed?
      true
    end

    def name
      view.to_sym
    end

    def view
      self.class.name.demodulize.gsub(/Step$/, '').underscore
    end

    def title
      self.class.title || self.class.name.demodulize.titleize
    end
  end
end
