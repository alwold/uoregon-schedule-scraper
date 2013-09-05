require 'uoregon_schedule_scraper'

describe UoregonScheduleScraper do
  it "shows open class as open" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201203', '31481').should eq(:open)
  end

  it "shows closed class as closed" do
    s = UoregonScheduleScraper.new
    s.get_class_status('201301', '17787').should eq(:closed)
  end

  it "loads class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201203', '31481')
    info.name.should eq("  ART 115   Surface, Space, & Time")
    info.schedule.should eq("t 1200-1350")
  end

  it "loads more class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201301', '17787')
    info.name.should eq("  AAA 408   Wrk Indv Brand Strateg")
    info.schedule.should eq("  tba")
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
