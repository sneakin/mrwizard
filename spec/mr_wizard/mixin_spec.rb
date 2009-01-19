require File.join(File.dirname(__FILE__), "../spec_helper")

describe MrWizard::Mixin do
  before(:each) do
    @controller = TestController.new
    @controller.response = ActionController::AbstractResponse.new
    @controller.params = HashWithIndifferentAccess.new(:step => :alpha, :wizard => { :data => 'Hello' } )
  end

  describe "#wizard" do
    it "is a helper method" do
      TestController.helpers.methods.include? :wizard
    end

    it "creates instance of the generated wizard class only once and returns it" do
      @controller.should_receive(:create_wizard).at_most(:once).and_return(:wizard)

      @controller.wizard.should == :wizard
      @controller.wizard.should == :wizard
    end
  end

  describe "#show" do
    before(:each) do
      @controller.stub!(:render)
    end

    it "assigns the wizard's title to :title" do
      lambda { @controller.show }.should change { @controller.instance_variable_get('@title') }
    end

    it "renders the show action" do
      @controller.should_receive(:render).with(:action => 'show')

      @controller.show
    end
  end

  describe "#create" do
    after(:each) do
      @controller.create
    end

    it "updates the wizard with the :wizard params" do
      @controller.wizard.should_receive(:update).with(@controller.params[:wizard]).and_return(true)
    end

    describe "successfully updates the wizard" do
      before(:each) do
        @controller.wizard.should_receive(:update).and_return(true)
      end

      it "redirects to the wizard's URL with the wizard's next step" do
        @controller.should_receive(:redirect_to).with(@controller.wizard.url(:step => @controller.wizard.next_step))
      end
    end

    describe "fails to update the wizard" do
      before(:each) do
        @controller.wizard.should_receive(:update).and_return(false)
      end

      it "performs the show action" do
        @controller.should_receive(:show)
      end
    end
  end
end
