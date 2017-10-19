class Game
  attr_accessor :partie, :player1, :player2, :teams

  def initialize
    #TO DO : créé 2 joueurs, créé un board
    @player1 = Player.new('Véronique', 'O')
    @player2 = Player.new('Davina', 'X')
    @teams = [@player1.team, @player2.team]

    @partie = Board.new(@teams)
    
  end

  def go
    # TO DO : lance la partie
    puts "------------------------------------------"
    puts "Here we go ! c'est le début de la partie !"
    puts "------------------------------------------"

    turn(@player1)
  end

  def turn(player)
    #TO DO : affiche le plateau, demande au joueur il joue quoi, vérifie si un joueur a gagné, passe au joueur suivant si la partie n'est pas finie
    puts "Hey #{player.name} de l'équipe #{player.team} , tu joues quoi ?"
    input = gets.chomp
    @partie.play(player, input)
    @partie.win_detect(player)
    puts ""
    @partie.to_s
    puts ""

    if player.winner
      puts ""
      puts "STTTOOOOPPPP"
      puts ""
      puts "THIS IS A WIN ! ! !"
      puts ""
      puts "Félicitation #{player.name} !!"
      # return pour mettre fin au jeu ;)
      return
    end

    while !@player1.winner && !@player2.winner
      puts ""
      puts "Bien jouééé çaaaaaaa !"
      puts "Mais y a pas encore de gagnant ! On continue !"
      puts "- - - - - - - - - - - - - - - - - - -"
      puts ""

      if player.name == @player1.name
        turn(@player2)
      else
        turn(@player1)
      end
    end

  end

end