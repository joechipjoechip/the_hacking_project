class Board
  include Enumerable
  #TO DO : la classe a 1 attr_accessor, une array qui contient les BoardCases
  attr_accessor :arrCases


  def initialize
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

    # donc ça donnera un tableau comme ça :
    # 
    #       1     2     3 
    # 
    # A    1A    2A    3A
    # 
    # B    1B    2B    3B
    # 
    # C    1C    2C    2C

  end

  def to_s
  #TO DO : afficher le plateau
    puts "     1     2     3"
    puts "A  #{@arrCases[0]}   #{@arrCases[1]}   #{@arrCases[2]}"
    puts "B  #{@arrCases[3]}   #{@arrCases[4]}   #{@arrCases[5]}"
    puts "C  #{@arrCases[6]}   #{@arrCases[7]}   #{@arrCases[8]}"

  end

  def play
    #TO DO : une méthode qui change la BoardCase jouée en fonction de la valeur du joueur (X, ou O)
  end

  def victory?
    #TO DO : qui gagne ?
  end
end