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

namespace :xcodeproj do
  desc "Generate the xcodeproj file"
  task :generate do
    # removed
  end
end

desc "run the tests"
task :test => "test:run"

task :compile => "build:framework"

Dir.glob(File.dirname(__FILE__) + "/support/rake/**/*.rake").each { |rakefile| load rakefile }
