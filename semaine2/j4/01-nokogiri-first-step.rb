# require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'rest-client'
require 'pry'


# version open-uri
# page = Nokogiri::HTML(open("https://en.wikipedia.org/"))

# binding.pry

# version restclient
page = Nokogiri::HTML(RestClient.get "https://en.wikipedia.org/")

puts page