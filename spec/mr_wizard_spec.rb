require File.join(File.dirname(__FILE__), "spec_helper")

describe MrWizard do
  it "generated a class derived from MrWizard::Base as its wizard_class" do
    TestController.wizard_class.superclass.should == MrWizard::Base
  end

  it "mixed in MrWizard::Mixin" do
    TestController.should be_include(MrWizard::Mixin)
  end

  it "sets the wizard's :url to :wizard_url" do
    TestController.wizard_class.url.should == :wizard_url
  end

  it "sets the wizard's steps to the specified steps" do
    TestController.wizard_class.steps.should == [ :alpha, :beta ]
  end
end
