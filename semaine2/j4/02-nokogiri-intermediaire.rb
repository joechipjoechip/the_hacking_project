# require 'rubygems'
require 'nokogiri'
# require 'open-uri'
require 'rest-client'
require 'pry'

# variables 
url = "https://en.wikipedia.org/"
# version open-uri
# page = Nokogiri::HTML(open("https://en.wikipedia.org/"))

# version restclient
page = Nokogiri::HTML(RestClient.get(url))

# puts page


# we want only links
links = page.css('body a.interlanguage')

# p links

mon_tab_durl = []

links.each do |link|
  mon_tab_durl << link["href"]
end

puts links