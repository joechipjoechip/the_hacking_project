class Utilisateur
	attr_accessor :nom, :amis

	def initialize(nom, sexe)
		
		if sexe =="f"
			@nom = "Madame " + nom
		else
			@nom = "Monsieur " + nom
		end
	end


	def estAmiAvec?(valeur)
		amis.each do |ami|
			return true if ami.nom == valeur
		end
		return false
	end
end

alice = Utilisateur.new("Alice", "f")
bob = Utilisateur.new("Bob", "h")
jane = Utilisateur.new("Jane", "f")

alice.amis = [bob]
bob.amis = [alice, jane]
jane.amis = "noone"



test = bob.nom

puts "----------------"
puts "Alice est elle amie avec #{test} ?"
puts alice.estAmiAvec?("#{test}")

phraseNbrAmis = "Alice a #{alice.amis.length} ami"

if alice.amis.length > 1
	phraseNbrAmis<< "s"
end

puts phraseNbrAmis

puts "----------------"