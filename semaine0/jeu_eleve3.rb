class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end

  def info
    vaincu = " est Vaincu!"
    enVie = " a (#{points_de_vie}/100) HP."
    if points_de_vie <= 0
      return infos = "le #{nom}" + vaincu
    else
		  return infos = "le #{nom}" + enVie 
    end
  end

  def attaque(personne)
    # A faire:
    # - Fait subir des dégats à la personne passée en paramètre
    subit_attaque(personne, @nbDegats)
  end

  def subit_attaque(personne, degats_recus)
    # A faire:
    personne.points_de_vie = personne.points_de_vie - degats_recus
    if personne.points_de_vie < 1
      personne.en_vie = false
    end
    puts "#{personne.nom} a subit #{degats_recus} points de dégats de la part du #{nom}."
    # - Réduit les points de vie en fonction des dégats reçus
    # - Affiche ce qu'il s'est passé
    # - Détermine si la personne est toujours en_vie ou non
  end
end

class Joueur < Personne
  attr_accessor :degats_bonus, :nbDegats

  def initialize(nom)
    # Par défaut le joueur n'a pas de dégats bonus
    @degats_bonus = 0
	  @nbDegats = 35

    # Appelle le "initialize" de la classe mère (Personne)
    super(nom)
  end

  def degats
    # A faire:
    # - Calculer les dégats
	  @nbDegats = @degats_bonus + @nbDegats
	  return @nbDegats
    # - Affiche ce qu'il s'est passé
    puts "#{nom} inflige #{nbDegats} points de dégats."
  end

  def soin
    # A faire:
    # - Gagner de la vie
	  @points_de_vie = @points_de_vie + 45
    # - Affiche ce qu'il s'est passé
	  puts "#{nom} s'est soigné et a maintenant #{points_de_vie} HP."
  end

  def ameliorer_degats
    # A faire:
    # - Augmenter les dégats bonus
	  @degats_bonus = @degats_bonus + 15
    degats
    # - Affiche ce qu'il s'est passé
	  puts "#{nom} a augmenté son attaque et inflige maintenant #{nbDegats} points de dégats." 
  end
end

class Ennemi < Personne
	attr_accessor :nbDegats

  def initialize(nom)
    @nbDegats = 12
    super(nom)
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

  def self.est_fini(joueur, monde)
    # A faire:
    # - Déterminer la condition de fin du jeu
    if monde.ennemis.length < 1 && joueur.en_vie
      puts "\n"
      puts "Vous avez gagné !"
      return true
    elsif !joueur.en_vie
      puts "\n"
      puts "Vous avez été vaincu !"
      return true
    else
      return false
    end
  end
end

class Monde
  attr_accessor :ennemis

  def ennemis_en_vie
    # A faire:
    # - Ne retourner que les ennemis en vie
    ennemis.each do |ennemi|
      if !ennemi.en_vie
        ennemis.delete(ennemi)
      end
    end

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
joueur = Joueur.new("Jean-Michel Crapo")

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
    monde.ennemis.each do |ennemi| 
      puts "#{ennemi.info}"
    end
    monde.ennemis_en_vie
  end

  if Jeu.est_fini(joueur, monde)
    puts "Vous avez terminé l'aventure en #{tour} tours"
    break
  end

  puts "\nLES ENNEMIS RIPOSTENT !"
  # Pour tous les ennemis en vie ...
  monde.ennemis_en_vie.each do |ennemi|
    # ... le héro subit une attaque.
    ennemi.attaque(joueur)
  end

  if Jeu.est_fini(joueur, monde)
    puts "Vous avez terminé l'aventure en #{tour} tours"
    break
  else
    puts "\nEtat du héro: #{joueur.info}\n"
  end
end