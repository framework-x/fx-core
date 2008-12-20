
namespace :test do
  
  task :run => %w[build:tests] do
    env = "DYLD_FRAMEWORK_PATH=#{File.dirname(__FILE__)}/../../build/Debug:/Developer/Library/Frameworks DYLD_FALLBACK_FRAMEWORK_PATH=#{File.dirname(__FILE__)}/../../../iphone/frameworks:/System/Library/Frameworks OBJC_DISABLE_GC=YES"
    otest = "arch -arch i386 /Developer/Tools/otest"
    framework = "build/Debug/UnitTests.octest"
    
    if ENV["file"] && ENV["test"]
      options = "-SenTest #{File.basename(ENV["file"], ".m").delete("+")}/#{ENV["test"]}"
      output_filter = ""
    elsif ENV["file"]
      options = "-SenTest #{File.basename(ENV["file"], ".m").delete("+")}"
      output_filter = ""
    else
      options = ""
      output_filter = "| ruby #{File.dirname(__FILE__) + '/display_ocunit_failures_at_end.rb'}"
    end
    sh "set -o pipefail && #{env} #{otest} #{options} #{framework} 2>&1 #{output_filter}"
  end
  
end
