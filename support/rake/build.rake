namespace :build do

  desc "clean and compile the framework"
  task :clean_and_compile do
    sh "rm -rf build"
    Rake::Task["compile"].invoke
  end
  
  desc "compile the framework"
  task :framework => %w[xcodeprojgen] do
    sh "xcodebuild -project FrameworkXCore.xcodeproj -sdk macosx10.5 -configuration Debug -target FrameworkXCore"
  end

  desc "build the tests"
  task :tests => :compile do
    sh "set -o pipefail && xcodebuild -project FrameworkXCore.xcodeproj -sdk macosx10.5 -configuration Debug -target UnitTests"  
  end
  
end