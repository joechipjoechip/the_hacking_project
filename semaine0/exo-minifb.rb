class Utilisateur
	attr_accessor :nom, :amis

	def estAmiAvec?(valeur)
		amis.each do |ami|
			return true if ami.nom == valeur
		end
		return false
	end
end

alice = Utilisateur.new
bob = Utilisateur.new
jane = Utilisateur.new

alice.nom = "Alice"
alice.amis = [bob]

bob.nom = "Bob"
bob.amis = [alice, jane]

jane.nom = "Jane"
jane.amis = "noone"

test = "Bob"
puts "Alice est elle amie avec #{test} ?"
puts alice.estAmiAvec?("#{test}")

phraseNbrAmis = "Alice a #{alice.amis.length} ami"

if alice.amis.length > 1
	phraseNbrAmis<< "s"
end

puts phraseNbrAmis