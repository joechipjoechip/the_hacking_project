require 'nokogiri'
require 'rest-client'
require 'pry'
require 'json'

# variables globales
$i = 1

# Functions

class Go_scrap_departement

  attr_accessor :infos

  def initialize(infos)
    @url_dep = infos[:lien_communes]

    @old_selector = "p.Style22 > font"
    @new_selector = ".section-border:first-of-type table tr:nth-of-type(4) > td:nth-of-type(2)"
    @url_de_base = "http://annuaire-des-mairies.com/"

    puts "Leeching : #{infos[:nom_departement]} : #{$i} / #{$total}"
  end

  def store_link_to_mairie
    tabLink = []
    hash_links = {}

    page = Nokogiri::HTML(RestClient.get(@url_dep))

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

    old = check_old_version(page_mairie)

    if old
      recup = page_mairie.css(@old_selector)
      tried = tri_dat_datas(recup)
      email = tried[0]
      referent = tried[1]

      # Obligé de faire ces opérations chelous pour pouvoir se débarasser du &nbsp;
      email = remove_this_fucking_whitespace(email)
      referent = remove_this_fucking_whitespace(referent)
    else
      recup = page_mairie.css(@new_selector)
      email = recup.text
      referent = "info non disponible"
    end
    
    dat_mairie = { 
      :email => email,
      :maire => referent
    }

    rescue => e
      puts "Pb d'encodage, mais on continue le programme car ça ne change rien dans notre cas"

    return dat_mairie
  end

  def tri_dat_datas(recup)
    email = ""
    referent = ""

    recup.each do |elem|
      if /@/.match(elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8"))
        email = elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8")
      end

      if /Monsieur|Madame/.match(elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8"))
        referent = elem.children.text.force_encoding('ISO-8859-1').encode("UTF-8")
      end
    end

    tabResult = [email, referent]

    return tabResult
  end

  def remove_this_fucking_whitespace(chaine)
    chaine = chaine.split('')
    # chaine = chaine.slice(2, chaine.size - 1)
    # provoque un pb d'encodage ?!
    chaine.shift
    chaine.shift
    # et deux shift règlent le pb d'encodage .. ?!?!
    chaine = chaine.join
    return chaine
  end

  def check_old_version(page)
    if page.css(@old_selector).size > 0
      return true
    else
      return false
    end
  end

  def perform
    return store_link_to_mairie
  end
end


class Go_scrap_country
  def initialize
    @url_de_base = "http://annuaire-des-mairies.com/"
  end

  def scrap_regions
    page = Nokogiri::HTML(RestClient.get(@url_de_base))
    hash_links = {}

    links = page.css('.section-border .container a.lientxt').each do |link|
      nomination = link.text.gsub(' ', '').split('|')
      num_dep, nom_dep = nomination[0], nomination[1]

      hash_links["#{num_dep}"] = {
        :nom_departement => nom_dep,
        :lien_communes => "#{@url_de_base}#{link["href"]}"
      }
    end

    return hash_links
  end

  def perform
    return scrap_regions
  end
end

scrap_em_all = Go_scrap_country.new
hash_departements = scrap_em_all.perform
$total = hash_departements.keys.size

# Pour tester sur une seule région :
# hash_departements["01"][:communes] = Go_scrap_departement.new(hash_departements["01"]).perform

hash_departements.keys.each do |key|
  hash_departements[key][:communes] = Go_scrap_departement.new(hash_departements[key]).perform
  $i += 1
end

bigJson = JSON.pretty_generate(hash_departements)
output = File.new("output_mairies.json", "w")
output.write(bigJson)
output.close

