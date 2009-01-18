class <%= class_name %>::<%= step_class %>Controller < ApplicationController
  mr_wizard :step, :for => :<%= name %>

  def show
    # show the step
  end

  def update
    # do what you expect here, but it's not from a PUT
    redirect_to next_step # when you're done
  end
end
