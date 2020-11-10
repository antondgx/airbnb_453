require "open-uri"
require "nokogiri"

def scrape_address
  url = "https://www.fakeaddressgenerator.com/All_countries/address/country/Singapore"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  address = html_doc.search(".no-style")[4].attribute("value")
end
