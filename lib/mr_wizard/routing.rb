module MrWizard
  module Routing
    def wizard(map, name, path_template = nil, options = Hash.new)
      path_template ||= "/#{name}"
      controller = options[:controller]
      RAILS_DEFAULT_LOGGER.debug("Routing wizard #{name}, #{path_template}, #{controller}")

      map.with_options :controller => controller, :defaults => { :step => nil } do |w|
        w.named_route(name, "#{path_template}/:step", :action => 'show', :conditions => { :method => :get })
        w.named_route("#{name}_form", "#{path_template}/:step", :action => 'create', :conditions => { :method => :post })
      end
    end
  end
end
