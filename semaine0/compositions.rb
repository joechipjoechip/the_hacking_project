class Classe
	attr_accessor :eleves
end


class Eleve
	attr_accessor :nom, :examens

	def moyenne
		total = 0
		examens.each do |i|
			total += i.note
		end
		return total / examens.size
	end

	def initialize(nom)
		@nom = nom
		puts "Eleve #{nom} créé"
	end
end


class Examen
	attr_accessor :nom, :note

	def initialize(nom,note)
		@nom = nom
		@note = note
		puts "examen #{nom} créé avec #{note}"
	end
end


billy = Eleve.new("Billy")

maths = Examen.new("maths", 10.0)
philo = Examen.new("philo", 15.0)

billy.examens = [maths, philo]




jj = Eleve.new("Jean Jacques")

crypto = Examen.new("crypto", 18.0)
francais = Examen.new("francais", 17.0)

jj.examens = [crypto, francais]


classe = Classe.new
classe.eleves = [billy, jj]


classe.eleves.each do |gaillard|
	puts "---------------\n\n"

	puts "Examens de #{gaillard.nom} :"

	gaillard.examens.each do |i|
		puts "#{i.nom} : #{i.note}"
	end

	puts "---------------\n"


	puts "Moyenne de #{gaillard.nom} : #{gaillard.moyenne}"

	puts "---------------\n\n"
end
