require 'rubygems'
require 'rake'
require 'spec'
 
require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:test) do |t|
  t.spec_opts = ['--options', "spec/spec.opts"]
  t.spec_files = FileList['spec/**/*_spec.rb']
end

desc "Migrate database"
task :auto_migrate do
  require 'lib/comp_scraper'
  DataMapper.auto_migrate!
end

desc "Upgrade database"
task :auto_upgrade do
  require 'lib/comp_scraper'
  DataMapper.auto_upgrade!
end
 
task :default => :test
