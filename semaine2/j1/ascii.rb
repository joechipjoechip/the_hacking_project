texte = "Hello World"

texte.size.times.each_with_index do |carac, index|
  puts texte[index].ord
end



puts "---- ----- ---- ----- --- -----"
# is equal to


"Hello World".each_char do |carac|
  puts carac.ord
end