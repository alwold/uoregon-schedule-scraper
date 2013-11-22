module UoregonSpecHelpers
  def get_current_term
    uri = URI("http://classes.uoregon.edu/")
    req = Net::HTTP::Get.new(uri.request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start do |http| 
      res = http.request(req)
    end
    doc = Nokogiri::HTML(res.body)
    doc.xpath("//table/tr/td[center/b/text()='Course Search By Term:']/ul/a")[0]['href'].split('=')[1]
  end
end
