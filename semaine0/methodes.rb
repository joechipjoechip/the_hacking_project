# méthode normale

# class Utilisateur
# 	attr_accessor :prenom, :nom

# 	def nom_complet
# 		prenom + " " + nom
# 	end
# end

# bob = Utilisateur.new
# bob.prenom = "bob"
# bob.nom = "lenon"

# nom_complet = bob.prenom + " " + bob.nom


# puts nom_complet




# methode avec parametres

class Utilisateur
	attr_accessor :prenom, :nom, :pays

	def nom_complet
		prenom + " " + nom
	end

	def habite_en(valeur)
		valeur == pays
	end
end

bob = Utilisateur.new
bob.prenom = "bob"
bob.nom = "lenon"
bob.pays = "france"

# nom_complet = bob.prenom + " " + bob.nom

testpays = "suisse"

puts "est ce que #{bob.nom} habite en #{testpays}"

if bob.habite_en("#{testpays}")
	puts "salut ami français"
else
	puts "salut ami venant de #{testpays}"
end
