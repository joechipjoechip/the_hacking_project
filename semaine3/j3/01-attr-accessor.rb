require 'pry'

class User

  attr_accessor :firstname, :lastname

  def initialize(firstname, lastname)
    @firstname = firstname
    @lastname = lastname
  end

  def full_name
    return "#{@firstname.capitalize} #{@lastname.capitalize}"
  end

end
nayana = User.new("Nayana", "Davis")
nayana.firstname = "Nayana"
puts nayana.firstname

binding.pry