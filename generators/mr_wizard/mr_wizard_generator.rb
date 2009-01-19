class MrWizardGenerator < Rails::Generator::NamedBase
  alias wizard_name name

  def manifest
    record do |m|
      steps = actions.collect { |step| step.underscore }

      logger.route "You need to add a route such as: map.wizard map, :#{name}, :controller => '#{name}' # make note of the 1st argument!"

      m.directory "app/controllers/#{name}"
      m.template 'controller.rb', "app/controllers/#{name}_controller.rb"
      m.template 'base_step.rb', "app/controllers/#{name}/step.rb"

      m.directory "spec/controllers/#{name}"
      m.directory "spec/views/#{name}"
      m.template 'controller_spec.rb', "spec/controllers/#{name}_controller_spec.rb", :assigns => { :steps => steps }

      m.directory "app/views/#{name}"
      m.file "show.html.erb", "app/views/#{name}/show.html.erb"
      m.template "show_spec.html.erb", "spec/views/#{name}/show.html.erb_spec.rb"
      m.template('step.html.erb', "app/views/#{name}/_done.html.erb",
                 :assigns => { :step => :done, :step_class => 'DoneStep' } )

      steps.each do |step|
        options = { :assigns => { :step => step, :step_class => step.classify } }
        m.template('step.rb', "app/controllers/#{name}/#{step}_step.rb", options)
        m.file('step.html.erb', "app/views/#{name}/_#{step}.html.erb")
        m.template('step_spec.rb', "spec/controllers/#{name}/#{step}_step_spec.rb", options)
        m.template('step_spec.html.erb', "spec/views/#{name}/_#{step}.html.erb_spec.rb", options)
      end
    end
  end
end                                                 
