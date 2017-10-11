# requires
require 'Twitter'
require 'json'
require 'pry'

# variables
file = File.read('myKeys.json')
hash_keys = JSON.parse(file)

# global variables
@client = Twitter::REST::Client.new(hash_keys["config"])
@stream = Twitter::Streaming::Client.new(hash_keys["config"])


# functions
def write(content)
  @client.update(content)  
end

def launch_stream(keyword)
  i = 0
  output = File.new("output.json", "w+")

  if keyword.match(/\s/)
    keyword = keyword.gsub(/\s/, ' AND ')
  end

  output.write('{ 
  "output" : [')
  
  stream_process(keyword, output, i)
end

def stream_process(keyword, output, i)
  while i <= @tweet_nb_limit
    @stream.filter(:track => keyword) do |tweet|
        if tweet.is_a?(Twitter::Tweet)
          
          user = tweet.user.screen_name
          text = tweet.text.to_s

          text = text.gsub('"', "'")
          text = text.gsub(/\n|\r/, "--")

          if i <= @tweet_nb_limit
            show_console(user, text, i)
            write_in_file(output, user, text, i)
          else
            close_file(output)
            return
          end

          i += 1
        end
    end
  end
end

def close_file(monFile)

  closing_stuffs = "
  ]
}"

  monFile.write(closing_stuffs)
  monFile.close
end

def write_in_file(file, user, text, i)
  # templating each an entry
  line = "
    {
      \"name\" : \"#{user}\",
      \"tweet\" : \"#{text}\"
    }"

  # managing the last coma
  if i != @tweet_nb_limit
    line = line + ','
  end
  file.write(line)
end

def show_console(user, text, i)
  # just a little console feedback to see where at instant T
  puts i
  puts "-> -> \" #{user} \" <- <- said :"
  puts text
  puts "------------------------------------"
end

# Start script !
puts "Quelle recherche ? (plusieurs mots : possible, séparés par un espace)"
keyword = gets.chomp.to_s

puts "Combien de résultats max ?"
@tweet_nb_limit = gets.chomp.to_i

if keyword && @tweet_nb_limit
  launch_stream(keyword)
end

