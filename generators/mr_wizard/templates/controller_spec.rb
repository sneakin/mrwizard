require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe <%= class_name %>Controller do
  it "is a wizard" do
    <%= class_name %>::Base.should be_kind_of?(MrWizard::Mixin)
  end
end
