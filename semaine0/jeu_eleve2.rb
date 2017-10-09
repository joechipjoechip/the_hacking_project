class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end




	#
	# Afficher les infos de la personne
	# On affiche son nom et ses points de vie. Si il est mort, on 'affiche a la place de ses points de vie
  #
	def info
    if !@en_vie
      "#{@nom} : (vaincu)"
    else
      "#{@nom} : #{@points_de_vie} points de vie"
    end
  end



	#
	# La personne attaque une autre presonne
	# On va chercher ses dégats (méthode degats) et on fait subir ces point de degats
	# à la personne attaqué
  #
	def attaque(personne)
		puts "#{@nom} attaque #{personne.nom}"
		pts_degat = self.degats
		personne.subit_attaque(pts_degat)
		
		puts "\n"
  end


  #
	# La personne subut une attaque
	# On déduit les points de dégat reçu des points de vie
	# Si il reste 0 (ou moins) point de vie => la personne est morte
	#
  def subit_attaque(degats_recus)
	  puts " |- #{nom} subit #{degats_recus} points de dégat"
		
		@points_de_vie -= degats_recus
		
		if @points_de_vie <= 0
		  @points_de_vie = 0
			@en_vie = false
			puts " |- #{@nom} est mort !!! RIP"
		else
		  puts " |- Il reste à #{@nom} #{@points_de_vie} points de vie"
		end
  end
end


class Joueur < Personne
  attr_accessor :degats_bonus

  def initialize(nom)
    # Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0

    # Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end

	#
	# Calcul des dégat du joueur (nombre aléatoire) + points de dégat bonus
	#
  def degats
		pts_degat = Random.rand(10...20)
		puts " |- #{@nom} prépare son attaque (#{pts_degat} point de dégat). Il dispose en plus de #{@degats_bonus}  points de dégat bonus"
		return pts_degat + @degats_bonus
  end


	#
	# Le joueur se soigne de N points (nombre aléatoire)
	#
  def soin
		puts "#{@nom} tente de se soigner"
		pts_soin = Random.rand(10...40)
		@points_de_vie += pts_soin
		
		if pts_soin == 0
		  puts " |- #{@nom} n'a pas réussi a se soigné"
		elsif @points_de_vie > 100
			@points_de_vie = 100
		  puts " |- #{@nom} se soigne de #{@pts_soin} points mais il ne peut pas récupérer plus de 100 points de vie."
		else
		  puts " |- #{@nom} se soigne de #{@pts_soin} points. Il dipose désormais de #{@points_de_vie} points de vie"
		end
  end

  
	#
	# Le joueur améliore ses dégats bonus de N points (nombre aléatoire)
	#
  def ameliorer_degats
		puts "#{@nom} tente d'améliorer ses dégats bonus"
	  nb = Random.rand(0...10) 
		@degats_bonus += nb
		
		if nb == 0
		  puts " |- #{@nom} n'a pas réussi a augmenter ses dégats bonus"
		else
		  puts " |- #{@nom} augmente ses dégats bonus de #{@nb} points. Il dipose désormais de #{@degats_bonus} points de dégat bonus"
		end
  end
end


class Ennemi < Personne
  
	#
	# Calcul des dégat du joueur (nombre aléatoire). Pas de points de dégat bonus pour les ennemis
	#
	def degats
    pts_degat = Random.rand(1...10)
		puts " |- #{nom} dispose de #{pts_degat} point de dégat"
		return pts_degat
  end
end



class Jeu
  def self.actions_possibles(monde)
    puts "ACTIONS POSSIBLES :"

    puts "0 - Se soigner"
    puts "1 - Améliorer son attaque"

    # On commence à 2 car 0 et 1 sont réservés pour les actions
    # de soin et d'amélioration d'attaque
    i = 2
    monde.ennemis.each do |ennemi|
      puts "#{i} - Attaquer #{ennemi.info}"
      i = i + 1
    end
    puts "99 - Quitter"
  end


	#
	# Le jeu est fini si le joueur est morts ou si il ne reste plus aucun énnemi en vie
	#
  def self.est_fini(joueur, monde)
		return !joueur.en_vie || monde.ennemis_en_vie.size == 0
  end
end


class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
		retour = []
		
		ennemis.each do |enemi|
		  if enemi.en_vie
				retour << enemi
			end
		end
		
		return retour
  end
end

##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis
monde.ennemis = [
  Ennemi.new("Balrog"),
  Ennemi.new("Goblin"),
  Ennemi.new("Squelette")
]

# Initialisation du joueur
joueur = Joueur.new("Jean-Michel Paladin")

# Message d'introduction. \n signifie "retour à la ligne"
puts "\n\nAinsi débutent les aventures de #{joueur.nom}\n\n"

# Boucle de jeu principale
100.times do |tour|
  puts "\n------------------ Tour numéro #{tour} ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
  elsif choix == 1
    joueur.ameliorer_degats
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    break
  else
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car les choix 0 et 1 étaient réservés pour le soin et
    # l'amélioration d'attaque
    ennemi_a_attaquer = monde.ennemis[choix - 2]
    joueur.attaque(ennemi_a_attaquer)
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  puts "\nEtat du héro: #{joueur.info}\n"

  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"

# A faire:
# - Afficher le résultat de la partie

if joueur.en_vie
  puts "Vous avez gagné !"
else
  puts "Vous avez perdu !"
end




