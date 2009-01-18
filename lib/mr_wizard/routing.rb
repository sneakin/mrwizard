module MrWizard
  module Routing
    def wizard(map, name, *args)
      options = args.pop if args.last.kind_of? Hash
      options ||= Hash.new

      path_template = args.pop
      path_template ||= "/#{name}"

      controller = options[:controller]

      map.with_options(:controller => controller, :defaults => { :step => nil }) do |w|
        w.named_route(name.to_s, "#{path_template}/:step",
                      :action => 'show',
                      :conditions => { :method => :get })
        w.named_route("#{name}_form", "#{path_template}/:step",
                      :action => 'create',
                      :conditions => { :method => :post })
      end
    end
  end
end
