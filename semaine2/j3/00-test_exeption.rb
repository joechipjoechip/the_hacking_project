class Test

  def calcul(x)
    @x = x

    begin 

      result = x / 0

      rescue ZeroDivisionError => e
        result = "Error of division : #{e.message}"
      else
        result = "non tout s'est bien passé, ton resultat est : #{result}"

    end


    return result

  end

end

variable = Test.new

puts variable.calcul(90)

