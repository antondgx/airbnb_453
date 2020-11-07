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

# scrape rating and rating count info from imdb
# def fetch_imdb_info(url)
#   if url
#     html_file = open(url).read
#     html_doc = Nokogiri::HTML(html_file)
#     # get rating
#     rating = html_doc.search(".ratingValue strong span").text.strip
#     # get rating count
#     rating_count = html_doc.search("a .small").text.strip.gsub(",","").to_f
#     if html_doc.search(".poster img").attribute("src")
#       # movie image address
#       movie_image_address = html_doc.search(".poster img").attribute("src").value
#     else
#       movie_image_address = ""
#     end
#     # array of single movie imdb info
#     [rating, rating_count, url, movie_image_address]
#   else
#     ""
#   end
# end
