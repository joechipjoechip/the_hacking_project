class Test

  def calcul(x)
    @x = x

    result = x / 0

    rescue ZeroDivisionError => e
      result = "Error of division, boi : #{e.message}"
    else
      result = "non tout s'est bien passé, ton resultat est : #{result}"

    return result

  end

end

variable = Test.new

puts variable.calcul(90)

