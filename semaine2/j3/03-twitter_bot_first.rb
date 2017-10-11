#!/usr/bin/env ruby

require 'Twitter'
require 'json'
require 'pry'

file = File.read('myKeys.json')
hash_keys = JSON.parse(file)

@client = Twitter::REST::Client.new(hash_keys["config"])


# send a tweet with command line
# @client.update('Mon 1er tweet en ligne de commande ... (test)')x
def write(content)
  @client.update(content)  
end


# @client.search('eminem trump').take(5).each do |tweet|
#   result << tweet.text
# end
def search(lookFor, limit, displayDat)
  result = []

  @client.search(lookFor).take(limit).each do |tweet|
    result << tweet.text
  end

  if displayDat
    puts result
  end
end


def search_with_options(lookFor, options, limit, displayDat)

  result = []

  @client.search(lookFor, options).take(limit).each do |tweet|
    result << tweet.text
  end

  if displayDat
    puts result
  end
end


def search_with_options_and_action(lookFor, options, limit, actions, message_action, displayDat)

  result = []

  @client.search(lookFor, options).take(limit).each do |tweet|

    if actions[:update]
      # binding.pry
      @client.update("@#{tweet.user.screen_name}, #{message_action}")
    end

    if actions[:favorite]
      @client.favorite(tweet)
    end

    # stock infos about actions that we've just done  
    result << "le bot a répondu le message à -> #{tweet.user.screen_name} - qui avait tweeté : #{tweet.text}"
  end

  if displayDat
    puts result
  end
end



# -----

# search('eminem trump', 10, true)

# -----

my_options = {
  result_type: "recent",
  geocode: "48.8566140,2.3522220,120mi"
}

# search_with_options('trump eminem', my_options, 7, true)

# -----

my_actions = {
  :update => true,
  :favorite => false
}

search_with_options_and_action('Mélenchon', my_options, 10, my_actions, "Mélenchon for the win, boiiiiiii", true)

# -----





