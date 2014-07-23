require 'uoregon_schedule_scraper'
require 'uoregon_spec_helpers'

RSpec.configure do |config|
  config.include UoregonSpecHelpers
end

describe UoregonScheduleScraper do
  it "can get current term" do
    expect(get_current_term.length).to eq(6)
  end
  it "can get a current class" do
    open = get_class(get_current_term, :open)
    expect(open.crn.length).to eq(5)
    closed = get_class(get_current_term, :closed)
    expect(closed.crn.length).to eq(5)
  end

  it "shows open class as open" do
    s = UoregonScheduleScraper.new
    open = get_class(get_current_term, :open)
    s.get_class_status(open.term_code, open.crn).should eq(:open)
  end

  it "shows closed class as closed" do
    s = UoregonScheduleScraper.new
    closed = get_class(get_current_term, :closed)
    s.get_class_status(closed.term_code, closed.crn).should eq(:closed)
  end

  it "loads class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201203', '31481')
    info.name.should eq("ART 115 Surface, Space, & Time")
    info.schedule.should eq("t 1200-1350")
  end

  it "loads more class info" do
    s = UoregonScheduleScraper.new
    info = s.get_class_info('201301', '17787')
    info.name.should eq("AAA 408 Wrk Indv Brand Strateg")
    info.schedule.should eq("tba")
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
