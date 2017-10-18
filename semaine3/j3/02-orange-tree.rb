require 'pry'

class Orange_tree

  attr_accessor :tall, :age, :nb_oranges

  def initialize
    @tall = 0
    @age = 0
    @nb_oranges = 0
  end

  def height
    return "#{tall} feet(s)"
  end

  def one_year_passed
    @age += 1
    @tall += 1

    if @age >= 5
      @nb_oranges = 20 + @age
    end

    if @age >= 50
      @age = 0
      @tall = 0
    end
  end

  def count_the_oranges
    return @nb_oranges
  end

  def pick_an_orange
    if @nb_oranges > 0
      @nb_oranges -= 1
    end
  end

end

class Orange_trees_manager

  attr_accessor :tree_collection, :one_tree

  def initialize
    @tree_collection = []
  end

  def add_tree(one_tree)
    @tree_collection << one_tree
  end

  def show_trees
    return @tree_collection
  end

  def one_year_for_all
    @tree_collection.each do |this_tree|
      this_tree.one_year_passed
    end
  end

  def pick_for_all
    @tree_collection.each do |this_tree|
      this_tree.nb_oranges.times do 
        this_tree.pick_an_orange
      end
    end
    return "all have been picked"
  end

  def count_oranges_for_all
    @nb_all_oranges = 0
    @tree_collection.each do |this_tree|
      @nb_all_oranges += this_tree.nb_oranges
    end
    return @nb_all_oranges
  end

  def show_averages_infos
    total_height = 0
    total_nb_oranges = 0

    @tree_collection.each do |this_tree|
      total_height += this_tree.tall
      total_nb_oranges += this_tree.nb_oranges
    end

    av_height = total_height / tree_collection.size
    av_nb_orange = total_nb_oranges / tree_collection.size

    return "Averages --> height : #{av_height} // nb_oranges : #{av_nb_orange}"
  end

end


tree_1 = Orange_tree.new
tree_2 = Orange_tree.new

tree_1.one_year_passed
tree_1.one_year_passed
tree_1.one_year_passed
tree_1.one_year_passed
tree_1.one_year_passed
tree_1.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed
tree_2.one_year_passed

champs = Orange_trees_manager.new()

champs.add_tree(tree_1)
champs.add_tree(tree_2)

puts champs.show_averages_infos

binding.pry
