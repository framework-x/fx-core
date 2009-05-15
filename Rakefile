IPHONE_ROOT = File.dirname(__FILE__)

class Rake::Task
  def overwrite(&block)
    @prerequisites.clear
    @actions.clear
    enhance(&block)
  end
end

task :default => :test
task :pc => :test

desc "Generate the xcodeproj file"
task :xcodeprojgen do
  puts "commented out for now"
  # sh "xcodeprojgen"
  # sh "rm -rf FrameworkXCore.xcodeproj"
  # sh "mv fx-core.xcodeproj FrameworkXCore.xcodeproj"
end

desc "run the tests"
task :test => "test:run"

task :compile => "build:framework"

Dir.glob(File.dirname(__FILE__) + "/support/rake/**/*.rake").each { |rakefile| load rakefile }
