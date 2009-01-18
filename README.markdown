MrWizard
========

MrWizard makes it easy to create wizards for your Rails app. It provides the
base classes for your wizard's controller and steps, and a generator that you
can use to easily generate the files needed for your wizard.


Generation
==========

    ./script/generate mr_wizard contact personal_info survey message

That will generate:

* ContactController
* Steps under `apps/controllers/contact`
* Views for the wizard and each step under `apps/views/contact`
* Specs under `spec/controllers/contact` for each step
* Specs for the views under `spec/views/contact`

You will want to edit each step's definition and view to tailor it for your
application. You may also need to edit the base class for each step too.


Routing
=======

MrWizard provides a routing helper that simplifies creating named routes for
your wizard. In `config/routes.rb` you just need to add a line such as:

    map.wizard map, :contact, :controller => 'contact'

*Warning!* Take note of the first argument. You have to pass it the routing mapper to
ensure prior options are maintained such as when you nest a wizard under a
resource.


Resources
=========

* [MrWizard](http://github.com/sneakin/mrwizard)
* [SemanticGap](http://www.semanticgap.com/)
* [Rails](http://rubyonrails.org/)


Legal
=====

Copyright (c) 2009 SemanticGap(R), released under the MIT license

SemanticGap(R) is a registered service mark of Nolan Eakins. All rights reserved.