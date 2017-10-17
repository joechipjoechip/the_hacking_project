require 'json'
require 'gmail'
require 'pry'
require 'mail'
require 'gmail_xoauth'

mdp = File.read('mdp.json')
mdp = JSON.parse(mdp)
# mdp = mdp["user1"]
mdp = "xxxxxxx"
username = "xxxxxxxx"



gmail = Gmail.connect(:xoauth2, "xxxxxxxx@gmail.com", token)
puts gmail.inbox.count(:read)




# Gmail.connect(username, mdp) do |gmail|
#   puts gmail.inbox.count(:read)
#   # binding.pry  
# end

# truc = Gmail.new("joechipjoechip", mdp)

# gmail = Gmail.connect(username, mdp)
# # play with your gmail...
# puts gmail
# puts gmail.inbox.count(:read)

# gmail.logout



# moults essais pour arriver à :
# Ok donc après lecture des threads du slack, visiblement il faut autoriser
# son propre gmail à accepter les connexions à des applications non sécurisés

# mon adresse gmail étant à la fois mon adresse perso, et mon adresse buisness, 
# j'ai l'authentification à deux facteurs activées
# donc il faudrait que : je désactive la F2A, pour désactiver encore une autre sécurité
# pour me rendre ultra vulnérable "juste le temps de l'exo"

# désolé mais nope, trop sensible ce qu'il y a là dessus,
# créer une adresse spéciale pour l'exo ? et la voir éternellement liée à la mienne ?... nope again.


# donc ok, je voyais le principe, c'est cool, y a plein de trucs à faire, 
# un des ces 4, je prendrais le temps pour me pencher là dessus, mais là j'ai pas l'temps.


# désolé, c'est pas de la mauvaise volonté, y a qu'à voir, jme suis chauffer pour faire 
# un scrap qui pécho -toutes- les mairies de France (19660 adresses mails à peu près)
# donc jsuis chaud bouillant, mais là, jpeux pas faire sauter ces sécrutités là
# j'ai la banque, les coins, etc.. toute ma vie la dessus.
