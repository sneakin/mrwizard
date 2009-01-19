require File.join(File.dirname(__FILE__), "../spec_helper")

describe MrWizard::Base do
  class TestWizard < MrWizard::Base
    self.steps = [ :alpha, :beta ]
    self.url = :wizard_url
  end

  before(:each) do
    @controller = TestController.new
    @step_name = :alpha
    @wizard = TestWizard.new(@step_name, @controller)
  end

  describe "initialize" do
    it "assigns :controller" do
      @wizard.controller.should == @controller
    end

    describe 'with a valid step' do
      it "creates the step" do
        @wizard.step.should be_kind_of(Test::AlphaStep)
      end
    end

    describe 'with a nil step' do
      it "uses the first step" do
        @wizard = TestWizard.new(nil, @controller)
        @wizard.step.should be_kind_of(Test::AlphaStep)
      end
    end

    describe 'with an invalid step' do
      it "uses the first step" do
        @wizard = TestWizard.new(:wtf, @controller)
        @wizard.step.should be_kind_of(Test::AlphaStep)
      end
    end
  end

  describe '#step_name' do
    it "returns the step class\' modularized class name" do
      @wizard.send(:step_name, :beta).should == "Test::BetaStep"
    end
  end

  describe '#create_step' do
    def do_it(*args)
      @wizard.send(:create_step, *args)
    end

    describe 'with a nil name' do
      it "raises an ArgumentError" do
        lambda { do_it(nil) }.should raise_error(ArgumentError)
      end
    end

    describe 'with a step name' do
      it "returns an instance of step whose name matches" do
        do_it(:beta).should be_kind_of(Test::BetaStep)
      end
    end

    describe 'with :done' do
      it "returns an instance of DoneStep" do
        do_it(:done).should be_kind_of(MrWizard::DoneStep)
      end
    end

    describe 'with a bad step name' do
      it "raises an ArgumentError" do
        lambda { do_it(:wtf) }.should raise_error(ArgumentError)
      end
    end
  end

  describe '#title' do
    it "returns the step\'s title" do
      @wizard.step.should_receive(:title).and_return(:title)

      @wizard.title.should == :title
    end
  end

  describe '#show' do
    it "is delegated to the step" do
      @wizard.step.should_receive(:show).and_return(:show)

      @wizard.show.should == :show
    end
  end

  describe '#update' do
    before(:each) do
      @params = { :data => 'Hello' }
    end

    it "sets the params to the supplied argument" do
      lambda { @wizard.update(@params) }.should change(@wizard, :params).to(@params)
    end

    it "updates the step" do
      @wizard.step.should_receive(:update)

      @wizard.update(@params)
    end
  end

  describe '#params' do
    it "is a reader" do
      @params = { :hello => :world }
      @wizard.instance_variable_set("@params", @params)

      @wizard.params.should == @params
    end
  end

  describe '#next_step' do
    describe 'on a zero step wizard' do
      before(:each) do
        @wizard = MrWizard::Base.new(nil, @controller)
      end

      it "returns :done" do
        @wizard.next_step.should == :done
      end
    end

    describe 'on a single step wizard' do
      class SingleStepWizard < MrWizard::Base
        self.steps = [ :alpha ]
      end

      describe 'on the first step' do
        before(:each) do
          @wizard = SingleStepWizard.new(:alpha, @controller)
        end

        it "returns :done" do
          @wizard.next_step.should == :done
        end
      end
    end

    describe 'on a two step wizard' do
      class TwoStepWizard < MrWizard::Base
        self.steps = [ :alpha, :beta ]
      end

      describe 'without a current step' do
        before(:each) do
          @wizard = TwoStepWizard.new(nil, @controller)
        end

        it "returns the second step's name" do
          @wizard.next_step.should == :beta
        end
      end

      describe 'on the first step' do
        before(:each) do
          @wizard = TwoStepWizard.new(:alpha, @controller)
        end

        describe 'with a needed second step' do
          it "returns the second step" do
            @wizard.next_step.should == :beta
          end
        end

        describe 'with an unneeded second step' do
          class UnneededStep < MrWizard::Step
            def name
              :beta
            end

            def needed?
              false
            end
          end

          before(:each) do
            @wizard.stub!(:create_step).with(:beta).and_return(UnneededStep.new(@wizard))
          end

          it "returns :done" do
            @wizard.next_step.should == :done
          end
        end
      end

      describe 'on the second step' do
        before(:each) do
          @wizard = TwoStepWizard.new(:beta, @controller)
        end

        it "returns :done" do
          @wizard.next_step.should == :done
        end
      end

      describe 'on the done step' do
        before(:each) do
          @wizard = TwoStepWizard.new(:done, @controller)
        end

        it "returns :done" do
          @wizard.next_step.should == :done
        end
      end
    end
  end

  describe '#done?' do
    describe 'when on the DoneStep' do
      before(:each) do
        @wizard = TestWizard.new(:done, @controller)
      end

      it "returns true" do
        @wizard.should be_done
      end
    end

    describe 'when on any other step' do
      it "returns false" do
        @wizard.should_not be_done
      end
    end
  end

  describe '#url' do
    it "calls the method specified by the wizard\'s URL on the controller" do
      @controller.should_receive(:wizard_url).and_return(:url)

      @wizard.url.should == :url
    end

    describe 'without arguments' do
      it "passes the current step\'s name as the :step param" do
        @controller.should_receive(:wizard_url).
          with(:step => @wizard.step.name).
          and_return(:url)

        @wizard.url.should == :url
      end
    end

    describe 'with a :step param' do
      it "passes the supplied :step as the :step param" do
        @controller.should_receive(:wizard_url).
          with(:step => :beta).
          and_return(:url)

        @wizard.url(:step => :beta).should == :url
      end
    end

    describe 'with params, but no :step param' do
      it "merges in the other params" do
        @controller.should_receive(:wizard_url).
          with(:hello => :world, :step => @wizard.step.name).
          and_return(:url)

        @wizard.url(:hello => :world).should == :url
      end
    end
  end
end
