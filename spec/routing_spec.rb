require File.join(File.dirname(__FILE__), "spec_helper")

describe MrWizard::Routing do
  include MrWizard::Routing

  before(:each) do
    @map = mock(Object)
  end

  [ [ 'contact', { :controller => 'contact' } ],
    [ 'checkout', '/order/checkout', { :controller => 'order/checkout' } ],
    [ 'survey' ],
  ].each do |name, *args|
    options = args.pop if args.last.kind_of? Hash
    options ||= Hash.new
    path = args.pop || "/#{name}"
    controller = options[:controller] || name

    describe "for a wizard named :#{name}" do
      it "creates two named routes called `#{name}` and `#{name}_form`" do
        @map.should_receive(:named_route).
          with(name, "#{path}/:step",
               :controller => controller,
               :action => 'show',
               :conditions => { :method => :get },
               :defaults => { :step => nil } )
        @map.should_receive(:named_route).
          with("#{name}_form", "#{path}/:step",
               :controller => controller,
               :action => 'create',
               :conditions => { :method => :post },
               :defaults => { :step => nil } )

        wizard(@map, name, path, options)
      end
    end
  end
end
