bigArr = [
  { :GOO => 3, :MMM => 14, :ADBE => 12, :EA=> 13, :BA => 8, :KO => 10, :XOM => 20, :GPS => 7, :MCD => 11, :DIS => 15, :CRM => 6, :JNJ => 10 },
  { :GOO => 17, :MMM => 20, :ADBE => 3, :EA=> 10, :BA => 5, :KO => 19, :XOM => 12, :GPS => 6, :MCD => 15, :DIS => 9, :CRM => 10, :JNJ => 17 },
  { :GOO => 3, :MMM => 8, :ADBE => 15, :EA=> 5, :BA => 10, :KO => 5, :XOM => 15, :GPS => 13, :MCD => 10, :DIS => 18, :CRM => 5, :JNJ => 14 },
  { :GOO => 9, :MMM => 3, :ADBE => 6, :EA=> 9, :BA => 15, :KO => 6, :XOM => 8, :GPS => 1, :MCD => 10, :DIS => 15, :CRM => 18, :JNJ => 3 },
  { :GOO => 17, :MMM => 18, :ADBE => 4, :EA=> 6, :BA => 15, :KO => 18, :XOM => 3, :GPS => 12, :MCD => 19, :DIS => 3, :CRM => 7, :JNJ => 9 },
  { :GOO => 2, :MMM => 12, :ADBE => 8, :EA=> 3, :BA => 18, :KO => 20, :XOM => 5, :GPS => 11, :MCD => 3, :DIS => 9, :CRM => 8, :JNJ => 15 },
  { :GOO => 16, :MMM => 14, :ADBE => 2, :EA=> 17, :BA => 7, :KO => 13, :XOM => 1, :GPS => 15, :MCD => 15, :DIS => 10, :CRM => 9, :JNJ => 17 }
]


def monday_trading(hashArr)

  # on créé un hash vide (qu'on va remplir par la suite)
  forOneKey = {}

  # on récupère toutes les clés d'un hash typique, et on stocke ça dans un array : keysArr
  keysArr = hashArr[0].keys

  # on itère sur chacune des clés récupérées
  keysArr.each do |key|

    # pour chacune des key, on initialise un hash vide, qui sera rempli plus tard avec les infos dont on a besoin
    forOneKey[key] = {
      :name => "",
      :values => []
    }

    # on rempli :name (en convertissant en string la clé, et en supprimant le ":"" pour faire plus propre ^w^)
    forOneKey[key][:name] = key.to_s.sub(":", "")

    # ici on itère sur le grand tableau, pour aller chercher unes à unes, toutes les valeurs pour l'entreprise en cours
    hashArr.each do |hash|
      # on rempli :values qui sera un tableau stockant toutes les valeurs d'une entrprise jour par jour, dans l'ordre
      forOneKey[key][:values] << hash[key]
    end

  end

  # ici, notre forOneKey est bien rempli de toutes les infos requises

  # donc il s'agit maintenant de faire le traitement de l'exercice précédent :
  # déterminer le meilleur bénéfice (la plus grande différence positive) tout en stockant les index qui correspondent
  # .. et pour faire ça proprement, on va déléguer ce traitement à une fonction dédiée à cette tâche : gimme_benefs_days()

  return gimme_benefs_days(forOneKey)

end

def gimme_benefs_days(bigHash)

  # on créé un array qui va contenir tous nos résultats pour toutes les entreprises
  finalResult = []

  # on récupère toutes les clés de bigHash dans un array
  keys = bigHash.keys

  # on itère sur chacune des clés
  keys.each do |key|

    # on créé un hash vide qui va contenir tout nos résultats pour une entreprise
    result = {}

    # on créé un hash vide de "best" qui servira plus tard pour le calcul
    best = {:difference => 0}

    # on créé un arr vide, qui contiendra des hashs dans lequels seront stockés : un bénéfice et les index des jours correspondants
    benefArr = []

    # on itère sur chacune des valeurs de l'élement courant
    bigHash[key][:values].each_with_index do |value, index|

      # et sur chacune de ces valeurs, on itère pour aller la comparer aux autres valeurs de l'élement courant
      bigHash[key][:values].each_with_index do |compare_value, compare_index|

        # on conditionne : la différence ne nous intéresse que si :
        # - elle est comparée dans le sens chronologique : compare_index > index
        # - elle est positive (bénéfice) : compare_value - value > 0

        if compare_index > index && compare_value - value > 0

          # alors, on insère le bénéfice dans un benefArr
          benefArr << { 
            :name => bigHash[key][:name], 
            :difference => (compare_value - value), 
            :index_de_base => index, 
            :index_de_comparaison => compare_index 
          }

        end

      end

    end

    # ici on est toujours dans l'itération sur l'array des keys, et notre benefArr est rempli de tous les benefs potentiels
    # donc on peut en profiter pour trier nos bénéfs et ne garder que le plus optimal

    benefArr.each do |benef|
      # si le benef courant est meilleur que le benef stocké, alors on le remplace

      # if benef[:difference] > best[:difference]
      #   best = benef
      # end

      # on pourrait s'en tenir à ça, mais cette façon de faire ne gère pas les cas où deux bénéfs sont identiques
      # cette manière là renverra toujours le dernier bénéf optimal traité

      # on peut donc ajouter un brin de complexité pour traiter ce cas spécifique :
      # le cas où 2 bénéfs sont identiques :
      # alors il sera préférable de ne garder que le bénéf le plus rapide
      # c'est à dire celui où l'écart de temps est le plus petit
      # c'est à dire celui où index_de_comparaison - index_de_base sera le plus petit
      # pour ça on va faire une fonction à part : shorterBenef() qui prendra les 2 données à comparer
      # et retournera la plus optimale

      if benef[:difference] > best[:difference]

        best = benef

      elsif benef[:difference] === best[:difference] && best[:difference] != 0

        best = shorterBenef(best, benef)

      end

    end

    finalResult << best

  end

  return finalResult

end

def shorterBenef(benefA, benefB)

  delaiBenefA = benefA[:index_de_comparaison] - benefA[:index_de_base]
  delaiBenefB = benefB[:index_de_comparaison] - benefB[:index_de_base]

  if delaiBenefA === delaiBenefB
    # si les deux délais sont égaux, on préfèrera celui qui apparait le plus tôt (chronologiquement)
    # donc celui dont index_de_base est le plus petit
    # pour ça on va déléguer à encore une autre fonction dédiée à cette tâche : 
    # soonerBenef() qui prend en arguments benef1 et benef2
    optimal = soonerBenef(benefA, benefB)
  else

    if delaiBenefB < delaiBenefA
      optimal = benefB
    else
      optimal = benefA
    end

  end

  return optimal

end


def soonerBenef(benef1, benef2)

  if benef1[:index_de_base] <= benef2[:index_de_base]
    sooner = benef1
  else
    sooner = benef2
  end

  return sooner
end


puts monday_trading(bigArr)