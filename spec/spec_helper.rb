require 'rubygems'
require 'spec'

$: << File.join(File.dirname(File.dirname(__FILE__)), 'lib') << File.dirname(File.dirname(__FILE__))

require 'active_support'
require 'action_controller'
require 'init'

module Test
  class AlphaStep < MrWizard::Step
  end

  class BetaStep < MrWizard::Step
  end
end

class TestController < ActionController::Base
  mr_wizard :url => :wizard_url, :steps => [ :alpha, :beta ]

  def wizard_url(params)
    "http://somehappyurl.com/"
  end
end
