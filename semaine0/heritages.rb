class Animal
	attr_accessor :nom

	def initialize(nom)
		@nom = nom
	end
end



class Chien < Animal
	def parler
		puts "#{nom} : wafwaf"
	end
end

class Chat < Animal
	def parler
		puts "#{nom} : miaaou"
	end
end


monChien = Chien.new("Bob le chien")
monChat = Chat.new("Misa le chat")


puts monChien.parler
puts monChat.parler