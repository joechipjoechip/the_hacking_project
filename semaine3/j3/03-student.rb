require 'pry'

class Student

  attr_reader :name, :age
  attr_writer :name

  def initialize(name, age)
    @name = name
    @age = age
  end
end

polo = Student.new('polo', 9)

polo.name = 'Jeannine'
# now polo's name is Jeannine

polo.age = 77
# trow error, and it's a normal shit
# because there is no attr_writer for :age

binding.pry