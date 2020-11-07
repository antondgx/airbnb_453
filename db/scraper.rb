require "open-uri"
require "Nokogiri"

def scrape_address
  url = "https://www.fakeaddressgenerator.com/All_countries/address/country/Singapore"
  html_file = open(url).read
  html_doc = Nokogiri::HTML(html_file)
  # get the the first url in the list
  # guard against crash
  address = html_doc.search(".no-style")[4].attribute("value")
end
