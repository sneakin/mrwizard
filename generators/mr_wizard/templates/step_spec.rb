require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= class_name %>::<%= step_class %>Step do
  it "is a step" do
    <%= class_name %>::<%= step_class %>Step.should be_kind_of?(MrWizard::Step)
  end
end
