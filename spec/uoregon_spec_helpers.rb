require 'class_info'

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

  def get_class(term, status)
    uri = URI("http://classes.uoregon.edu/pls/prod/hwskdhnt.P_ListCrse?term_in=#{term}&sel_subj=dummy&sel_day=dummy&sel_schd=dummy&sel_insm=dummy&sel_camp=dummy&sel_levl=dummy&sel_sess=dummy&sel_instr=dummy&sel_ptrm=dummy&sel_attr=dummy&sel_cred=dummy&sel_tuition=dummy&sel_open=dummy&sel_weekend=dummy&sel_title=&sel_to_cred=&sel_from_cred=&sel_subj=ENG&sel_crse=&sel_crn=&sel_camp=%25&sel_levl=%25&sel_attr=%25&begin_hh=0&begin_mi=0&begin_ap=a&end_hh=0&end_mi=0&end_ap=a&submit_btn=Show+Classes")
    req = Net::HTTP::Get.new(uri.request_uri)
    http = Net::HTTP.new(uri.host, uri.port)
    res = http.start do |http| 
      res = http.request(req)
    end
    doc = Nokogiri::HTML(res.body)
    class_rows = doc.xpath("//table/tr[td[@class='dddefault']]")
    class_rows.each do |row|
      crn = row.xpath('td')[1].text
      seats = row.xpath('td')[2].text.to_i
      if status == :open && seats > 0
        ci = ClassInfo.new
        ci.term_code = term
        ci.crn = crn
        return ci
      elsif status == :closed && seats == 0
        ci = ClassInfo.new
        ci.term_code = term
        ci.crn = crn
        return ci
      end
    end
    nil
  end
end
