require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= class_name %>Controller do
  it "is a wizard" do
    <%= class_name %>Controller.should be_include(MrWizard::Mixin)
  end

  it "sets the wizard's URL to :<%= name %>_path" do
    <%= class_name %>Controller.wizard_class.url.should == :<%= name %>_path
  end

  [ <%= steps.collect { |s| ":#{s}" }.join(", ") %> ].each do |step|
    it "has :#{step} as a step" do
      <%= class_name %>Controller.wizard_class.steps.should include(step)
    end
  end
end
