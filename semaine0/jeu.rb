class Personne
  attr_accessor :nom, :points_de_vie, :fullLife, :en_vie, :frappe, :cible, :degats_recus

  def initialize(nom)
    @nom = nom
    @en_vie = true
    @points_de_vie = @fullLife
  end

  def infos
    # A faire:
    # - Renvoie le nom et les points de vie si la personne est en vie
    # - Renvoie le nom et "vaincu" si la personne a été vaincue
	if @en_vie == true    
    	puts "#{nom} a #{points_de_vie} points de vie"
    else
    	puts "#{nom} is dead"
    end

  end

  def attaque(cible)
    @cible = cible
  
	puts "#{nom} attaque #{cible.nom} (#{cible.points_de_vie} hp) et lui inflige #{frappe} points de dégats"

	subit_attaque(cible, frappe)
  end

  def subit_attaque(cible, degats_recus)
  	@cible = cible
  	@degats_recus = degats_recus 

    cible.points_de_vie = cible.points_de_vie - degats_recus
    puts "il reste donc #{cible.points_de_vie} hp à #{cible.nom}"
    if cible.points_de_vie < 1
    	cible.en_vie = false
    	puts "#{cible.nom} est tué lors de cet affrontement épic; RIP #{cible.nom}"
    end
  end
end




class Joueur < Personne
  attr_accessor :degats_bonus, :heal

  def initialize(nom)
    @degats_bonus = 11
    @frappe = 15
    @fullLife = 200
    @heal = 55

    # Appelle le "initialize" de la classe mère (Personne)
    # obligé ??
    super(nom)
    
  end

  def degats
    # A faire:
    # - Calculer les dégats
    # - Affiche ce qu'il s'est passé
    @frappe = @frappe + @degats_bonus
  end

  def soin
    # A faire:
    # - Gagner de la vie
    # - Affiche ce qu'il s'est passé
    # points_de_vie = points_de_vie + 20
    @points_de_vie += @heal
    
    # les points_de_vie ne doivent pas dépasser la jauge max (fullLife)
    if @points_de_vie > @fullLife
    	@points_de_vie = @fullLife
    end

    puts "#{nom} à retrouvé #@heal points de vie, il est donc à #@points_de_vie"
    # done
  end

  def ameliorer_degats
    # A faire:
    # - Augmenter les dégats bonus
    # - Affiche ce qu'il s'est passé

    @frappe += @degats_bonus
    puts "Dégats Bonus ! -> Les dégats de #{nom} on été augmentés de #@degats_bonus points"
    puts "Dorénavant, #{nom} dispose d'une force de frappe de #@frappe points ! Impressive !"
    # done
  end
end




class Ennemi < Personne
	def initialize(nom, fullLife, frappe)
		@nom = nom
		@fullLife = fullLife
		@frappe = frappe

		super(nom)
		@points_de_vie = fullLife
  	end

  	def ennemis_en_vie
		if @en_vie == true
	    	return self
		end 
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
    	if ennemi.ennemis_en_vie == ennemi
	      puts "#{i} - Attaquer #{ennemi.nom} #{ennemi.points_de_vie} / #{ennemi.fullLife} hp"
	  	else
	  		puts "#{ennemi.nom} : terrassé !"
	  	end
		i = i + 1

    end
    puts "99 - Quitter"
  end

  def self.est_fini(joueur, monde)
    @joueur = joueur
    @monde = monde

    # on check si le joueur est en vie pour dire : gagné ou perdu
    if joueur.points_de_vie < 1
    	return true
    end

    # on check s'il reste un ennemi vivant
    # si un seul est en_vie == true , on retourne false (ce qui fait continuer le jeu)
    # si aucun n'est en vie, on retourne true (pour est_fini) ce qui aurra pour effet de stoper le jeu
    if monde.ennemis.any? {|i| i.en_vie == true} && joueur.points_de_vie >= 1
    	return false
    else
    	return true
    end

  end

  def self.riposte(monde, joueur)
  	@monde = monde
  	@joueur = joueur

  	puts "\nLES ENNEMIS RIPOSTENT !"

  	# tous les ennemis en_vie = true attaquent le joueur
  	monde.ennemis.each do |i|
	  	if i.en_vie == true
	  		i.attaque(joueur)
	  	end
  	end

  	# après une riposte, on affiche l'état du joueur
	puts "\nEtat du héros :\n"
  	puts joueur.infos
  end

  def self.over(monde, joueur, iteration, fuite)

  	puts "\nThe game is Over!\n\n\n"

  	# différentes fins de partie
  	if fuite == true
  		puts "Vous avez FUI, BOOUUUHHH\n\n"
  	elsif joueur.en_vie == true

  		if monde.ennemis.any? {|i| i.en_vie == true}

  			listeSurvivants = ""
  			monde.ennemis.each.with_index do |i, index|
		  		if i.en_vie == true
			  		if index == monde.ennemis.length - 2
			  			listeSurvivants = "#{listeSurvivants}#{i.nom}"
			  			index = index + 1
			  			listeSurvivants = "#{listeSurvivants} et #{monde.ennemis[index].nom}"
			  			break
			  		end
			  	end

		  		listeSurvivants = "#{listeSurvivants}#{i.nom}, "

		  	end

  			puts "Mouai, vous avez gagné à la montre quoi... pas terrible\n\n"
  			puts "#{listeSurvivants} viendront vous surprendre, un jour, sous votre douche, au moment où vous aurez du savon qui pique sur les yeux..\n\n"
  		
  		else
		  	
		  	listeMorts = ""
		  	monde.ennemis.each.with_index do |i, index|
		  		
		  		if index == monde.ennemis.length - 2
		  			listeMorts = "#{listeMorts}#{i.nom}"
		  			index = index + 1
		  			listeMorts = "#{listeMorts} et #{monde.ennemis[index].nom}"
		  			break
		  		end

		  		listeMorts = "#{listeMorts}#{i.nom}, "
		  	end
		  	puts "Vous avez gagné en #{iteration} tours !\n\n"
		  	puts "#{listeMorts} n'auraient pas du croiser votre chemin !\n\n\n\n"
		end
		

	elsif
	  	puts "Vous êtes décédé en héros !\n\n"
	end
  end

end




class Monde
  attr_accessor :ennemis
end

##############

# Initialisation du monde
monde = Monde.new

# Ajout des ennemis (nom, vie max, dégats)
monde.ennemis = [
  Ennemi.new("Balrog", 85, 15),
  Ennemi.new("Goblin", 80, 10),
  Ennemi.new("Squelette", 75, 5),
  Ennemi.new("Nadine Morano", 150, 1)
]


# Initialisation du joueur
joueur = Joueur.new("Jean-Michel Paladin")

# Message d'introduction.
puts "\n\nAinsi débutent les aventures de #{joueur.nom} (#{joueur.points_de_vie}/#{joueur.fullLife} hp)\n\n"

iteration = 1
fuite = false
tourMax = 50
# Boucle de jeu principale
while iteration < tourMax

  puts "\n------------------ Tour numéro #{iteration} / #{tourMax} ------------------"

  # Affiche les différentes actions possibles
  Jeu.actions_possibles(monde)

  puts "\nQUELLE ACTION FAIRE ?"
  # On range dans la variable "choix" ce que l'utilisateur renseigne
  choix = gets.chomp.to_i

  # En fonction du choix on appelle différentes méthodes sur le joueur
  if choix == 0
    joueur.soin
    Jeu.riposte(monde, joueur)
  elsif choix == 1
    joueur.ameliorer_degats
    Jeu.riposte(monde, joueur)
  elsif choix == 99
    # On quitte la boucle de jeu si on a choisi
    # 99 qui veut dire "quitter"
    fuite = true
    break
    # on exclu tous les choix non valables
  elsif choix > (monde.ennemis.length + 1) || choix > 99
  	# message d'erreur et on reste au même tour
  	puts "Please select a real choice given, THANKS\n\n"
  	iteration = iteration - 1
  else
  	
    # Choix - 2 car nous avons commencé à compter à partir de 2
    # car 0 -> soin et 1 -> boost degats
    ennemi_a_attaquer = monde.ennemis[choix - 2]

    #on vérifie si l'ennemi est en vie
    if ennemi_a_attaquer.en_vie == true
		# s'il est en vie on l'attaque
   		joueur.attaque(ennemi_a_attaquer)
   		# on test si le jeu est fini (joueur vivant et ennemis restant)
   		break if Jeu.est_fini(joueur, monde)
   		# on procède à la riposte
		Jeu.riposte(monde, joueur)
   	else
   		# si l'ennemi est mort : message
   		puts "#{ennemi_a_attaquer.nom} est déjà mort, rien ne sert de s'acharner sur une dépouille"
   		# et on reste au même tour
   		iteration = iteration - 1
    end
    
  end
  # obligé de répéter 2fois le break ?
  # car le 1er (ligne 305) ne fait que sortir du if (?..)
  break if Jeu.est_fini(joueur, monde)
  iteration = iteration + 1
  
end


Jeu.over(monde, joueur, iteration, fuite)


