dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]


def jean_michel_data(search, dictionary)

  result = {}

  dictionary.each do |word|

    if word.match(search)
      
      result[word] = 1

    end

  end

  return result

end


puts jean_michel_data('low', dictionary)
