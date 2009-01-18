class MrWizardGenerator < Rails::Generator::NamedBase
  alias wizard_name name

  def manifest
    record do |m|
      m.directory "app/controllers/#{name}"
      m.template 'base.rb', "app/controllers/#{name}/base_controller.rb", :collision => :skip

      m.directory "spec/controllers/#{name}"
      m.template 'spec.rb', "spec/controllers/#{name}/base_spec.rb"

      m.directory "app/views/#{name}"

      actions.each do |step|
        m.template 'step.rb', "app/controllers/#{name}/#{step}_controller.rb", :assigns => { :step => step, :step_class => step.classify }
      end

      logger.route "You need to add a route."
    end
  end
end                                                 
