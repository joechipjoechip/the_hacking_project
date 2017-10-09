class Hello_world

  def speak

    return "Hello World"

  end

end


describe Hello_world do

  context "Test if the good string is passed" do

    it "the .speak method should return a string 'Hello World'" do

      hw = Hello_world.new
      message = hw.speak
      expect(message).to eq "Hello World"
      # cette denière ligne peut aussi être :
      # expect(message) == "Hello World"

    end

  end

end
