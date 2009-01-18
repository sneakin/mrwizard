describe <%= class_name.classify %>::Base do
  it "is a wizard" do
    <%= class_name %>::Base.should be_kind_of?(MrWizard::Base)
  end
end
