require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'spec/rake/spectask'

desc 'Default: run unit tests.'
task :default => :spec

desc 'Test the mrwizard plugin.'
Spec::Rake::SpecTask.new(:spec) do |t|
  t.libs << 'lib'
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end

namespace :spec do
  desc 'Test the mrwizard plugin.'
  Spec::Rake::SpecTask.new(:rcov) do |t|
    t.rcov = true
    t.libs << 'lib'
    t.pattern = 'spec/**/*_spec.rb'
    t.verbose = true
  end
end

desc 'Generate documentation for the mrwizard plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Mrwizard'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
