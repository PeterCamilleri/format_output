require "bundler/gem_tasks"
require "rake/testtask"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :default => :test

desc "What version of format_output is this?"
task :vers do |t|
  puts
  puts "format_output version = #{::FormatOutput::VERSION}"
end
