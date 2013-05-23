require './lib/uoregon_schedule_scraper.rb'

s = UoregonScheduleScraper.new
puts s.get_class_status('201203', '31481')

info = s.get_class_info('201203', '31481')
if info.nil?
  puts "no info"
else
  puts "Name: " << info.name 
  puts "Schedule: " << info.schedule
end

puts s.get_class_status('201203', '31481')
# puts s.get_class_info('201230', 'stu150')

puts s.get_class_status('201203', '13322')
