require './lib/uoregon_schedule_scraper.rb'

s = UoregonScheduleScraper.new
puts s.get_class_status('201202', '22618')

info = s.get_class_info('201202', '22618')
if info.nil?
  puts "no info"
else
  puts "Name: " << info.name 
  puts "Schedule: " << info.schedule
end

puts s.get_class_status('201202', '26873')
# puts s.get_class_info('201230', 'stu150')