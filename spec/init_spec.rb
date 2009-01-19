require File.join(File.dirname(__FILE__), "spec_helper")

describe MrWizard, 'plugin init' do
  it "mixes MrWizard in with ActionController::Base" do
    ActionController::Base.should include(MrWizard)
  end

  it "mixes MrWizard::Routing in with ActionController::Routing::RouteSet::Mapper" do
    ActionController::Routing::RouteSet::Mapper.should include(MrWizard::Routing)
  end
end
