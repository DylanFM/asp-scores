require 'rubygems'
require 'rake'
require 'spec'
 
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end
 
task :default => :test
