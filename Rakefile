task :default do
  Rake::Task['run'].invoke
end

desc "Run the game."
task :run do
  sh "ruby src/loader.rb"
end

desc "Run the game in debug mode."
task :debug do
  sh "ruby src/loader.rb debug"
end
