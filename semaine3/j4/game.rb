class Game
  attr_accessor :partie, :player1, :player2

  def initialize
    #TO DO : créé 2 joueurs, créé un board
    @partie = Board.new()
    @player1 = Player.new('David', 'O')
    @player2 = Player.new('Goliath', 'X')
  end

  def go
    # TO DO : lance la partie
  end

  def turn
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
  end

end