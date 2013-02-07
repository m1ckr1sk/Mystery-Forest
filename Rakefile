task :default do
  Rake::Task['run'].invoke
end

desc "Run the game."
task :run do
  sh "ruby src/mystery_forest.rb"
end

desc "Run the game in debug mode."
task :debug do
  sh "ruby src/mystery_forest.rb debug"
end
