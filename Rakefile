require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :spec

def common_spec_opts(t)
  t.spec_opts = [ '-f', 'html:spec.html', '-fp' ]
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end

desc 'Test the mrwizard plugin.'
Spec::Rake::SpecTask.new(:spec) do |t|
  common_spec_opts(t)
end

namespace :spec do
  desc 'Test the mrwizard plugin.'
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.rcov = true
    common_spec_opts(t)
  end
end

desc 'Generate documentation for the mrwizard plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Mrwizard'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.markdown')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
