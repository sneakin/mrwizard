class <%= class_name %>::BaseController < ApplicationController
  mr_wizard :steps => [ <%= actions.collect { |s| ":#{s}" }.join(", ") %> ]
end
