failures = []
STDIN.each_line do |line|
  # puts line
  # next
  if line =~ /UnitTests.+finished/
    @finished = true
  end
  case line
  when /^Test Case .+ failed /
    failures << line.strip
    print "F"
  when /Test\.m:\d+: error/
    failures << line.strip
  when /^Test Case .+ passed /, /^Test Suite .+ started /, /^Test Suite .+ finished /
    print "."
  when /Executed.+test.+failure.+seconds/
    if @finished
      print "\n"
      puts line
    end
  when /is missing/
  when /^Error, could not create MachMessagePort for database doctor/
  else
    unless line.strip.empty?
      print "\n"
      puts line
    end
  end
  $stdout.flush
end
if failures.any?
  puts ""
  puts failures.join("\n")
  puts "#{failures.grep(/failed/).size} failures"
  puts ""
end

