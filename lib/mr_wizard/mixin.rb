module MrWizard
  module Mixin
    def self.included(base)
      base.helper_method :wizard
    end

    def show
      @title = wizard.title
      wizard.show(params[:wizard] || Hash.new)
      render :action => 'show'
    end

    def create
      if wizard.update(params[:wizard] || Hash.new)
        redirect_to(wizard.url(:step => wizard.next_step))
      else
        show
      end
    end

    def wizard
      @wizard ||= create_wizard
    end

    def create_wizard
      self.class.wizard_class.new(params[:step], self)
    end
  end
end
