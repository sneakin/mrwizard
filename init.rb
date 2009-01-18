require 'mr_wizard'

class ActionController::Base
  include MrWizard
end

class ActionController::Routing::RouteSet::Mapper
  include MrWizard::Routing
end
