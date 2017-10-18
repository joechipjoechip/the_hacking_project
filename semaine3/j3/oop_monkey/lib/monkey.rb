$voyelles = ["a", "e", "i", "o", "u", "y"]

class Monkey
  attr_accessor :name, :species, :foods_eaten

  def initialize(name, species)
    @name = name.capitalize
    @species = species
    @foods_eaten = []
  end

  def eat(food)
    if !$voyelles.include?(food[0])
      @foods_eaten << food
    end
  end

  def introduce
    return "Hey, i'm #{@name}, i'm a #{@species}, and I recently ate #{@foods_eaten.join(' and ')}"
  end

end
