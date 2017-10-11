#!/usr/bin/env ruby

require 'Twitter'
require 'json'
require 'pry'

file = File.read('myKeys.json')
hash_keys = JSON.parse(file)

@client = Twitter::REST::Client.new(hash_keys["config"])
@stream = Twitter::Streaming::Client.new(hash_keys["config"])


# send a tweet with command line
# @client.update('Mon 1er tweet en ligne de commande ... (test)')
def write(content)
  @client.update(content)  
end

def launch_stream(keyword)


  if keyword.match(/\s/)
    keyword = keyword.gsub(/\s/, ' AND ')
    # binding.pry
  end

  @stream.filter(:track => keyword) do |tweet|
      if tweet.is_a?(Twitter::Tweet)
        puts tweet.text

        # et donc ici, si on veut, on peut écrire un tweet de réponse avec
        # @client.update(content)  
        # on a bien sur accès à tweet.user.screen_name etc ...

      end
  end

end


puts "Quelle recherche ? (plusieurs mots : possible, séparés par un espace"
keyword = gets.chomp.to_s

launch_stream(keyword)

