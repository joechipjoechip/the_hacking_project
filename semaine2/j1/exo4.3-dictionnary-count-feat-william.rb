williamWords = ["the", "of", "and", "to", "a", "in", "for", "is", "on", "that", "by", "this", "with", "i", "you", "it", "not", "or", "be", "are"]


def jean_michel_data(search, dictionary)

  result = {}

  # search = search.downcase.gsub(/'|,|!|\?|\n/, " ").split(' ')
  dictionary = dictionary.downcase.gsub(/'|,|!|\?|\n/, " ").split(' ')

  search.each do |searchWord|

    nb = 0

    dictionary.each do |word|

      if word.match(searchWord)
        
        nb = nb + 1

      end

    end

    result[searchWord] = nb 

  end

  return result

end

def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")

  f.each_line do |line|
    data += line
  end
  
  return data
end

# pour tester on prend un truc un peu plus léger ...
# puts jean_michel_data(williamWords, get_file_as_string("shake-temp.txt"))

puts jean_michel_data(williamWords, get_file_as_string("shakespear.txt"))

