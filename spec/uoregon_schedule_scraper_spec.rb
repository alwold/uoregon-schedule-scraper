require 'uoregon_schedule_scraper'

describe UoregonScheduleScraper do
  it "shows closed class as closed" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201203', '31481').should eq(:closed)
  end

  it "loads class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201203', '31481')
    info.name.should eq("Surface, Space, & Time")
    info.schedule.should eq("t 1200-1350")
  end

  it "shows another closed class as closed" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201203', '31481').should eq(:closed)
# puts s.get_class_info('201230', 'stu150')
  end

  it "gets nil status for nonexistent class" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201203', '13322').should be_nil
  end

  it "gets nil class info for nonexistent class" do
    s = UoregonScheduleScraper.new
    s.get_class_info('201203', '13322').should be_nil
  end
end
