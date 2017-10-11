#!/usr/bin/env ruby

require 'Twitter'
require 'json'
require 'pry'

file = File.read('myKeys.json')
hash_keys = JSON.parse(file)

@client = Twitter::REST::Client.new(hash_keys["config"])
@stream = Twitter::Streaming::Client.new(hash_keys["config"])

@tweet_nb_limit = 10

def write(content)
  @client.update(content)  
end


def launch_stream(keyword)

  i = 0
  output = File.new("output.json", "w")

  if keyword.match(/\s/)
    keyword = keyword.gsub(/\s/, ' AND ')
  end

  output.write('{ 
  "output" :
    [')
  
  @stream.filter(:track => keyword) do |tweet|
      if tweet.is_a?(Twitter::Tweet)
        
        user = tweet.user.screen_name
        text = tweet.text.to_s

        text = text.gsub('"', "'")
        text = text.gsub(/\n|\r/, "--")

        # un ptit retour console histoire de voir
        puts "#{user} --- said :"
        puts text
        puts "------------------------------------"

        line = '
      {' + '
        "name" : "' + "#{user}" + '",' + 
          '
        "tweet" : "' + "#{text}" + '"' + 
          '
      }'

        if i < @tweet_nb_limit
          if i != @tweet_nb_limit - 1
            line = line + ','
          end
          output.write(line)
        else
          close_output(output)
        end

        i += 1
      end
  end

end

def close_output(monFile)

  closing_stuffs = "
    ]
  }"

  monFile.write(closing_stuffs)
  monFile.close

  # rescue => e
  #   puts "oui, il y a ce pb de fermeture de fichier, mais tout fonctionne correctement ..."
  #   puts "si qq1 a une solution .."

end

puts "Quelle recherche ? (plusieurs mots : possible, séparés par un espace"
# keyword = gets.chomp.to_s
keyword = "eminem"

launch_stream(keyword)

