require 'nokogiri'
require 'rest-client'
require 'pry'
require 'json'

# variables globales
@url_de_base = "http://annuaire-des-mairies.com/"
@selector = "p.Style22 > font"

# Functions
def store_link_to_mairie
  url_valdoise = "#{@url_de_base}val-d-oise.html"
  page = Nokogiri::HTML(RestClient.get(url_valdoise))

  tabLink = []
  hash_links = {}

  links = page.css('a.lientxt').each do |link|
    hash_links["#{link.text}"] = link["href"]
  end

  result = go_on_each(hash_links)
  return result
end


def go_on_each(leHash)
  keys = leHash.keys
  all_mairies = {}

  keys.each do |key|
    mairie_infos = go_to_this_mairie(key, leHash["#{key}"])
    all_mairies["#{key}"] = mairie_infos
  end

  return all_mairies
end


def go_to_this_mairie(nom, lien)
  lien = lien.gsub('./', '')
  url_mairie = "#{@url_de_base}#{lien}"
  page_mairie = Nokogiri::HTML(RestClient.get(url_mairie))
  dat_mairie = {}

  recup = page_mairie.css(@selector)
  tried = tri_dat_datas(recup)

  email = tried[0]
  referent = tried[1]

  # Obligé de faire ces opérations chelous pour pouvoir se débarasser du &nbsp;
  email = remove_this_fucking_whitespace(email)
  referent = remove_this_fucking_whitespace(referent)

  if email.nil?
    email = "email manquant"
  end

  if referent.nil?
    referent = "référent manquant"
  end

  dat_mairie = { 
    :email => email,
    :referent => referent
  }

  rescue => e
    puts "Pb d'encodage, mais on continue le programme car ça ne change rien dans notre cas"

  return dat_mairie
end


def tri_dat_datas(recup)

  email = ""
  referent = ""

  recup.each do |elem|
    if elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8").match(/@/)
      email = elem.children.text
    end

    if elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8").match(/Monsieur|Madame/)
      referent = elem.children.text
    end
  end

  tabResult = [email, referent]

  return tabResult

  rescue => e
    puts "mini crash"

end


def remove_this_fucking_whitespace(chaine)
  chaine = chaine.split('')
  chaine.shift
  chaine = chaine.join
  return chaine
end


# Starting !
bigHash = store_link_to_mairie
bigJson = JSON.pretty_generate(bigHash)

output = File.new("output_mairies.json", "w")
output.write(bigJson)
output.close

