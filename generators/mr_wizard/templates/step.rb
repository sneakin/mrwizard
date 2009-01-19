class <%= class_name %>::<%= step_class %>Step < <%= class_name %>::Step
  def needed?
    # return false if you want to skip this step
    true
  end

  def show
    # setup any objects needed to show the step
    # the rendering will be handled by the wizard's controller
  end

  def update
    # return false if the update fails and the step needs to be redisplayed
    true
  end
end
