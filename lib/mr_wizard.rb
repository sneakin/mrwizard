require 'mr_wizard/step_definition'
require 'mr_wizard/done_step'
require 'mr_wizard/step_instance'
require 'mr_wizard/base'
require 'mr_wizard/mixin'

module MrWizard
  def self.included(base)
    base.class_inheritable_accessor :wizard_class
    base.extend(ClassMethods)
  end

  module ClassMethods
    def mr_wizard(options = Hash.new, &block)
      include MrWizard::Mixin

      klass = Class.new(MrWizard::Base)
      klass.class_eval(&block)
      options.each { |k, v| klass.send("#{k}=", v) }
      self.wizard_class = klass
    end
  end
end
