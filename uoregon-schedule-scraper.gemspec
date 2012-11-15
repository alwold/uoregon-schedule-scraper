Gem::Specification.new do |s|
  s.name = "uoregon-schedule-scraper"
  s.version = "0.1"
  s.date = "2012-11-15"
  s.authors = ["Al Wold"]
  s.email = "alwold@gmail.com"
  s.summary = "Scrapes schedule data for University of Oregon"
  s.files = ["lib/uoregon_schedule_scraper.rb", "lib/uoregon_class_info.rb"]
  s.add_runtime_dependency "nokogiri"
end