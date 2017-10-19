class Board
  include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :arrCases, :teams


  def initialize(current_teams)
    #TO DO :
    #Quand la classe s'initialize, elle doit créer 9 instances BoardCases
    #Ces instances sont rangées dans une array qui est l'attr_accessor de la classe
    @arrCases = [
      BoardCase.new("1A"),
      BoardCase.new("2A"),
      BoardCase.new("3A"),

      BoardCase.new("1B"),
      BoardCase.new("2B"),
      BoardCase.new("3B"),

      BoardCase.new("1C"),
      BoardCase.new("2C"),
      BoardCase.new("3C")
    ]

    @teams = current_teams

    # donc ça donnera un tableau comme ça :
    # 
    #       1     2     3 
    # 
    # A    1A    2A    3A
    # 
    # B    1B    2B    3B
    # 
    # C    1C    2C    3C


    # donc combinaisons gagnantes :
    # case codée // index case dans @arrCases

    # 1A 2A 3A // 0 1 2
    # 1B 2B 3B // 3 4 5
    # 1C 2C 3C // 6 7 8
    # 
    # 1A 1B 1C // 0 3 6
    # 2A 2B 2C // 1 4 7
    # 3A 3B 3C // 2 5 8
    # 
    # 1A 2B 3C // 0 4 8
    # 3A 2B 1C // 2 4 6

  end

  def to_s
  #TO DO : afficher le plateau
    puts "   1   2   3"
    puts "A  #{@arrCases[0]}   #{@arrCases[1]}   #{@arrCases[2]}"
    puts "B  #{@arrCases[3]}   #{@arrCases[4]}   #{@arrCases[5]}"
    puts "C  #{@arrCases[6]}   #{@arrCases[7]}   #{@arrCases[8]}"
  end

  def play(player, case_played)
    # ici je traduit d'emblée le nom de la case en majuscules
    # pour que "1c" devienne direct "1C"
    case_voulue = case_played.upcase
    play_team = player.team

    # ici on détecte si le format de la case n'existe pas avec une regex (...)
    if !/^[0-3][A-C]$/.match(case_voulue)
      # si c'est le cas, on affiche un message d'erreur et on redemande une case
      puts ""
      puts "Mauvais format !"
      puts "Merci de donner une case au format colonne/ligne"
      puts "ex : 1A ou 2C ou 3B"
      input = gets.chomp
      play(player, input)
    end

    # on se balade sur chacune des cases
    @arrCases.each.with_index do |case_courante, index|
      # on vérifie si la case_courante match avec ce qui a été entré par le joueur (case_played)
      if case_courante.place == case_voulue

        # et si cette case n'a pas déjà été jouée
        if case_courante.value != @teams[0] && case_courante.value != @teams[1]

          # alors seulement, je peux inscrire le coup
          @arrCases[index].set_to(play_team)
        else
          puts ""
          puts "__ \/ ! \\/ ! \\/ ! \\/ ! \\/ ! \\ __"
          puts "Cette case a déjà été jouée ! ^w^"
          puts "Donne moi une case non-jouée .."
          input = gets.chomp
          play(player, input)
        end
      end
    end
  end

  def win_detect(player)
    # 1A 2A 3A // 0 1 2
    # 1B 2B 3B // 3 4 5
    # 1C 2C 3C // 6 7 8
    # 
    # 1A 1B 1C // 0 3 6
    # 2A 2B 2C // 1 4 7
    # 3A 3B 3C // 2 5 8
    # 
    # 1A 2B 3C // 0 4 8
    # 3A 2B 1C // 2 4 6

    win_patterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6]
    ]

    win_patterns.each do |one_pattern|
      if @arrCases[one_pattern[0]].value == player.team && @arrCases[one_pattern[1]].value == player.team && @arrCases[one_pattern[2]].value == player.team
        player.winner = true
      end
    end
    
  end

end