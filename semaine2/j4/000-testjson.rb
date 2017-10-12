require 'json'

bigHash = {
  :coucou => {
    :name => "joe",
    :age => 45
  }
}

leJson = JSON.generate(bigHash)

puts leJson

