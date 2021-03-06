class Personne
  attr_accessor :nom, :points_de_vie, :en_vie

  def initialize(nom)
    @nom = nom
    @points_de_vie = 100
    @en_vie = true
  end

  def info
    # A faire:
    # - Renvoie le nom et les points de vie si la personne est en vie
    # - Renvoie le nom et "vaincu" si la personne a été vaincue
    if @points_de_vie > 0 then
      return "#{@nom} (#{@points_de_vie}pv/100)."
    else
      return "#{@nom} (vaincu!)."
    end
  end

  def attaque(personne)
    # A faire:
    # - Fait subir des dégats à la personne passée en paramètre
    # - Affiche ce qu'il s'est passé
    print @nom + " attaque #{personne.nom},"
    personne.subit_attaque(degats)
  end

  def subit_attaque(degats_recus)
    # A faire:
    # - Réduit les points de vie en fonction des dégats reçus
    # - Affiche ce qu'il s'est passé
    # - Détermine si la personne est toujours en_vie ou non
    @points_de_vie -= degats_recus
    puts " et lui fait perdre #{degats_recus} pv."
    if @points_de_vie <= 0 then
      @en_vie = false
      puts "#{@nom} est terrassé!"
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

  def degats
    # A faire:
    # - Calculer les dégats
    # - Affiche ce qu'il s'est passé
    bonus_temp = @degats_bonus
    @degats_bonus = 0
    return rand(10...30) + bonus_temp
  end

  def soin
    # A faire:
    # - Gagner de la vie
    # - Affiche ce qu'il s'est passé
    if @points_de_vie == 100 then
      puts "#{@nom} est déjà à 100%."
      points_gagnes = 0
    elsif @points_de_vie > 75 then
      points_gagnes = rand(25)
    elsif @points_de_vie > 50 then
      points_gagnes = rand(10...25)
    else
      points_gagnes = rand(20...50)
    end
    if points_gagnes != 0 then
      @points_de_vie += points_gagnes
      puts "#{@nom} gagne #{points_gagnes}."
    end
  end

  def ameliorer_degats
    # A faire:
    # - Augmenter les dégats bonus
    # - Affiche ce qu'il s'est passé
    @degats_bonus = rand(15...30)
    puts "#{@nom} gagne #{@degats_bonus} points bonus pour sa prochaine attaque!"
  end
end

class Ennemi < Personne
  def degats
    # A faire:
    # - Calculer les dégats
    y = 15
    y = 10 if points_de_vie < 50
    y = 5 if points_de_vie < 15
    return rand(y)
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
    if joueur.en_vie == false || monde.ennemis_en_vie == [] then
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
    ennemis_vivants = []
    ennemis.each do |ennemi|
      if ennemi.en_vie == true then
        ennemis_vivants << ennemi
      end
    end
    return ennemis_vivants
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

  if monde.ennemis_en_vie != [] then
    puts "\nLES ENNEMIS RIPOSTENT !"
    # Pour tous les ennemis en vie ...
    monde.ennemis_en_vie.each do |ennemi|
      # ... le héro subit une attaque.
      ennemi.attaque(joueur)
    end
    puts "\nEtat du héro: #{joueur.info}\nBonus pour la prochaine attaque : #{joueur.degats_bonus}"
  end

  # Si le jeu est fini, on interompt la boucle
  break if Jeu.est_fini(joueur, monde)
end

puts "\nGame Over!\n"

# A faire:
# - Afficher le résultat de la partie
puts joueur.info
monde.ennemis.each do |ennemi|
  puts ennemi.info
end

if Jeu.est_fini(joueur, monde) == true && joueur.en_vie == true
  puts "Vous avez gagné !"
elsif Jeu.est_fini(joueur, monde) == false
  puts "Vous avez déclaré forfait !"
else
  puts "Vous avez perdu !"
end
