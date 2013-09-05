require 'uoregon_schedule_scraper'

describe UoregonScheduleScraper do
  it "shows open class as open" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201203', '31481').should eq(:open)
  end

  it "loads class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201203', '31481')
    info.name.should eq("  ART 115   Surface, Space, & Time")
    info.schedule.should eq("t 1200-1350")
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
