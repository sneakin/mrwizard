MrWizard
========

MrWizard makes it easy to create wizards for your Rails app. It provides the
base classes for your wizard's controller and steps, and a generator that you
can use to easily generate the files needed for your wizard.


Usage
=====

    ./script/generate mr_wizard contact personal_info survey message

That will generate:

* ContactController
* `personal_info`, `survey`, and `message` steps under `app/controllers/contact` along with a common base step.
* A show view for the wizard and a partial for each step under `app/views/contact`
* Specs under `spec/controllers/contact` for each step
* Specs for the views under `spec/views/contact`

You will want to edit each step's definition and view to tailor it for your
application. You may also need to edit the base class for each step too.


Controller
----------

The generated controller will have a structure similar to:

    class ContactController < ApplicationController
      mr_wizard :url => :contact_path, :steps => [
        :personal_info,
        :survey,
        :message
      ]
    end

You may add whatever filters and such that you want. `mr_wizard` defines the
`show` and `create` actions which handle requests by passing them off to the
controller's generated wizard class.


Steps
-----

The generated steps are not controllers. They derive from the generated base
step which is a subclass of `MrWizard::Step`. They'll typically look like:

    class Contact::PersonalInfoStep < Contact::Step
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

The `Contact::Step` superclass is shared with each step of the Contact wizard.
It provides a convinient location to define accessors and other shared methods.


Routing
=======

MrWizard provides a routing helper that simplifies creating named routes for
your wizard. In `config/routes.rb` you just need to add a line such as:

    map.wizard map, :contact, :controller => 'contact'

*Warning!* Take note of the first argument. You have to pass it the routing
mapper to ensure prior options are maintained such as when you nest a wizard
under a resource.


Sites
=====

* [MrWizard](http://github.com/sneakin/mrwizard)
* [SemanticGap](http://www.semanticgap.com/)
* [Rails](http://rubyonrails.org/)


Legal
=====

Copyright (c) 2009 SemanticGap(R), released under the MIT license

SemanticGap(R) is a registered service mark of Nolan Eakins. All rights reserved.
