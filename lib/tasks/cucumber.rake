$:.unshift(RAILS_ROOT + '/vendor/plugins/cucumber/lib')
require 'cucumber/rake/task'

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "--format pretty --require features/steps/helper"
end
task :features => 'db:test:prepare'
