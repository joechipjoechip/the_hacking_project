dictionary = ["below", "down", "go", "going", "horn", "how", "howdy", "it", "i", "low", "own", "part", "partner", "sit"]


def jean_michel_data(search, dictionary)

  # on créé un hash vide qui va contenir nos résultats
  result = {}

  # on prend search et on le redéfinit en lui faisant plusieurs trucs chainés :  
  # -> on met tout en minuscule 
  # + on remplace les ' les , et les ! et les ? par un espace 
  # + on split aux espaces pour mettre le tout dans un tableau
  search = search.downcase.gsub(/'|,|!|\?/, " ").split(' ')
  # ici search est un array avec un mot dans chaque slot

  # ce truc -> /'|,|!|\?/  c'est une "expression régulière",
  # c'est un peu un language dans le language, faut lire de la doc, c'est très spécial
  # ça permet de repérer des pattern ...
  # http://vfsvp.fr/article/utiliser-les-expressions-regulieres-en-ruby-1-sur-3/ <-- pour ruby
  # mais perso j'ai appris ça sur js : https://openclassrooms.com/courses/dynamisez-vos-sites-web-avec-javascript/les-expressions-regulieres-1-2

  # donc on itère sur ce tableau qu'on vient de créer
  search.each do |searchWord|
    # on met le nombre d'occurences trouvée à 0
    nb = 0

    # on itère sur les mots à trouver du dictionnaire
    dictionary.each do |word|

      # si le mot courant du dico match le searchWord courant
      if word.match(searchWord)
        
        # on incrémente le nb
        nb = nb + 1

      end

    end

    # à la fin de chaque searchWorld, on insère la clé et la valeur du nombre d'occurences dans le hash result
    result[searchWord] = nb 

  end

  # à la fin on retourne le hash result
  return result

end


puts jean_michel_data("Howdy partner, sit down! How's it going?", dictionary)







# > jean_michel_data("below", dictionary)
# => {"below"=>1, "low"=>1}

# > jean_michel_data("Howdy partner, sit down! How's it going?", dictionary)
# => {"down"=>1, "how"=>2, "howdy"=>1,"go"=>1, "going"=>1, "it"=>2, "i"=> 3, "own"=>1,"part"=>1,"partner"=>1,"sit"=>1}
