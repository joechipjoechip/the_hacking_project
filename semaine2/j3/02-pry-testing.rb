require 'pry'

def global

  @answer = 25

  puts "hey, choose a number !"

  def ask
    return gets.chomp.to_i
  end

  def check(user_guess)

    # to know user_guess and @answer
    # we can use :
    # binding.pry
    # like an IRB (during the execution)

    if @answer === user_guess
      puts "ok, you'r done !"
      return
    elsif user_guess > @answer
      puts "trop hiiiight"
      check(ask)
    else
      puts "trop loooow"
      check(ask)
    end
  end

  user_guess = ask
  check(user_guess)
end

global()





