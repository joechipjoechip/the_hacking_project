require 'json'
require 'gmail'
require 'pry'
require 'mail'

file = File.read('sensible.json')
file = JSON.parse(file)

mdp = file["p"]
username = file["l"]



Gmail.connect(username, mdp) do |gmail|

  email = gmail.compose do
    to "quituveux@hotmail.fr"
    subject "Hey Boiii, ceci est un test"

    # plain text way
    # body "Ceci est le corps du message, jeune pousse"

    # html way
    html_part do
      content_type 'text/html; charset=UTF-8'
      body "<p>Corps du <em>mail</em> au format <h2>HTML</h2>.</p>"
    end

    # pj
    add_file "testpj.png"
  end

  email.deliver!


end



