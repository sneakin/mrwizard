require File.join(File.dirname(__FILE__), "spec_helper")

describe MrWizard::Step do
  class TestStep < MrWizard::Step
  end

  before(:each) do
    @wizard = mock(MrWizard::Base)
    @step = TestStep.new(@wizard)
  end

  describe '#initialize' do
    it "assigns :wizard" do
      @step.wizard.should == @wizard
    end
  end

  describe "#params" do
    it "is delegated to the wizard" do
      @step.wizard.should_receive(:params).and_return(:params)

      @step.params.should == :params
    end
  end

  describe "#controller" do
    it "is delegated to the wizard" do
      @step.wizard.should_receive(:controller).and_return(:controller)

      @step.controller.should == :controller
    end
  end

  describe '#show' do
    it "returns true" do
      @step.show.should be_true
    end
  end

  describe '#update' do
    it "returns true" do
      @step.update.should be_true
    end
  end

  describe '#needed?' do
    it "returns true" do
      @step.should be_needed
    end
  end

  describe '#name' do
    it "returns the step\'s classname underscorized w/o the module as symbol" do
      @step.name.should == :test
    end
  end

  describe '#view' do
    it "returns step\'s classname underscorized w/o the module" do
      @step.view.should == 'test'
    end
  end

  describe '#title' do
    describe 'when the the step as an assigned title' do
      before(:each) do
        @step.class.title = 'Hello World'
      end

      after(:each) do
        @step.class.title = nil
      end

      it "returns the assigned title" do
        @step.title.should == 'Hello World'
      end
    end

    describe 'without an assigned title' do
      it "returns the step\'s classname w/o the module as a title" do
        @step.title.should == 'Test'
      end
    end
  end
end
