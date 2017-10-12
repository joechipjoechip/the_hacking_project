require 'nokogiri'
require 'rest-client'
require 'pry'

# variables globales
@url_de_base = "https://coinmarketcap.com/#EUR"

@selector = 'tbody tr'

def scrap(url)
  page = Nokogiri::HTML(RestClient.get(url))
  trTab = []

  page.css(@selector).collect do |oneTr|
    trTab << oneTr
  end

  lesKeys = []

  trTab.each do |tr|
    lesKeys << tr["id"]
  end

  lesKeys.shift

  prices = go_get_price(lesKeys, trTab)

  return prices
end

def go_get_price(keysArr, trTab)
  newHash = {}

  trTab.each do |tr|
    keysArr.each do |key|

      if tr.attributes["id"].value == key
        newHash[key] = tr.children[7].children[1].attributes["data-usd"].value
      end
      
    end

  end

  return newHash
end


# Starting !
puts scrap(@url_de_base)