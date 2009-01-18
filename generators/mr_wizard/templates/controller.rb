class <%= class_name %>Controller < ApplicationController
  mr_wizard :url => :<%= name %>_path, :steps => [
    <%= actions.collect { |s| ":#{s}" }.join(",\n    ") %>
  ]
end
