Rake::Task["pc"].overwrite do
  Rake::Task["h"].invoke    
  Rake::Task["svn:rm"].invoke  
  Rake::Task["svn:add"].invoke
  Rake::Task["svn:up"].invoke  
  Rake::Task["svn:fail_on_conflict"].invoke  
  Rake::Task["test"].invoke  
  Rake::Task["svn:st"].invoke  
  puts "success: okay to check in"    
end