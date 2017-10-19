require 'pry'

class Member

  attr_accessor :full_name

  def initialize(arg)
    @full_name = arg.capitalize
  end

  def get_full_name
    return @full_name
  end

  def introduce
    return "Hi, my blaze is #{@full_name}"
  end
end

class Student < Member

  attr_accessor :reason

  def initialize(name_given, mantra)
    @reason = mantra
    super(name_given)
  end
end

class Instructor < Member

  attr_accessor :bio, :skills

  def initialize(name_given, mantra)
    @bio = mantra
    @skills = []
    # le super sert à faire passer des infos à la classe parent
    # donc ici, il va faire appel au initialize de member, en donnant en argument "name_given"
    super(name_given)
  end

  def add_skill(skill)
    @skills << skill
  end
end

class Workshop

  attr_accessor :date, :classroom
  attr_reader :roaster_students, :group_instructors

  def initialize(date, classroom)
    @date = date
    @classroom = classroom
    @group_instructors = []
    @roaster_students = []
  end

  def add_participant(participant)
    if participant.instance_of? Student
      @roaster_students << participant
    elsif participant.instance_of? Instructor
      @group_instructors << participant
    end
  end

  def print_details
    puts "Workshop - #{@date} - #{@classroom}"
    puts "----------"
    puts "Instructors :"
    @group_instructors.each.with_index do |prof, index|
      all_skills = prof.skills.join(', ')
      puts "  #{index + 1} - #{prof.full_name} - Skills : #{all_skills}"
      puts "    #{prof.bio}"
    end
    puts "----------"
    puts "Students :"
    @roaster_students.each.with_index do |eleve, index|
      # binding.pry
      puts "  #{index + 1} - #{eleve.full_name} - #{eleve.reason}"
    end
    puts "----------"
  end
end


# exemples d'instances
jeanclaude = Instructor.new('jeanclaude', 'j\'adore l\'eau')
marguerite = Instructor.new('marguerite', 'j\'aime les tartines de composte')
polo = Student.new('polo', 'keep it real')
cynthia = Student.new('cynthia', 'nail art thiavu')

# exemples d'appels à des méthodes
marguerite.add_skill('repassage')
marguerite.add_skill('couture')
marguerite.add_skill('MMA')

jeanclaude.add_skill('bricolage')
jeanclaude.add_skill('picolage')
jeanclaude.add_skill('astrophysique')

coursdanglais = Workshop.new('jeudi', "salle 101")

coursdanglais.add_participant(polo)
coursdanglais.add_participant(cynthia)
coursdanglais.add_participant(marguerite)
coursdanglais.add_participant(jeanclaude)


# appel du print final
coursdanglais.print_details

# binding.pry
