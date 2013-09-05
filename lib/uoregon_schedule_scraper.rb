require 'net/http'
require 'nokogiri'
require 'ruby-debug'
require_relative 'uoregon_class_info'

class UoregonScheduleScraper
  def get_class_info(term_code, class_number)
    doc = fetch_info(term_code, class_number)
    results_table = doc.xpath("//table[@class='datadisplaytable']")
    if results_table.empty?
      return nil
    end
    rows = results_table.xpath("tr")
    name = strip(rows[0].xpath("td/b").text)
    cells = rows[5].xpath("td")
    schedule = strip(cells[5].text)
    schedule << " " if !schedule.empty?
    schedule << strip(cells[4].text)
    if name != nil
      UoregonClassInfo.new(name, schedule)
    else
      nil
    end
  end

  def get_class_status(term_code, class_number)
    doc = fetch_info(term_code, class_number)
    results_table = doc.xpath("//table[@class='datadisplaytable']")
    if results_table.empty?
      return nil
    end
    rows = results_table.xpath("tr")
    name = rows[0].xpath("td/b").text
    cells = rows[5].xpath("td")
    open_seats = cells[2].text.to_i
    if open_seats == 0
      :closed
    else
      :open
    end
  end

private
  def string_value(node)
    if node == nil
      nil
    else
      strip(node.to_s)
    end
  end

  def fetch_info(term_code, class_number)
    # TODO have this rotate between servers
    uri = URI("http://classes.uoregon.edu/pls/prod/hwskdhnt.p_viewdetl?term=#{term_code}&crn=#{class_number}")
    req = Net::HTTP::Get.new(uri.request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start do |http| 
      res = http.request(req)
    end
    doc = Nokogiri::HTML(res.body)
    # this somehow makes decoding of entities work (https://twitter.com/#!/tenderlove/status/11489447561)
    doc.encoding = "UTF-8"
    return doc
  end

  def strip(str)
    str.strip.gsub("\u00A0", "")
  end
end
