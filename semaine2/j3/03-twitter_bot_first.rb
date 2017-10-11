#!/usr/bin/env ruby

require 'Twitter'
require 'json'

file = File.read('myKeys.json')
hash_keys = JSON.parse(file)

client = Twitter::REST::Client.new(hash_keys["config"])

client.update('Mon 1er tweet en ligne de commande ... (test)')


# puts hash_keys["config"]

