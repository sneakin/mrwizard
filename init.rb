class ActionController::Base
  include MrWizard
end

ActionController::Base.append_view_path File.join(File.dirname(__FILE__), "views")
