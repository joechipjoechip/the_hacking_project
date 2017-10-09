multiples = []
somme = 0;

999.times do |nb|
  if nb % 3 === 0 || nb % 5 === 0
    multiples << nb
  end
end

# puts multiples

multiples.each do |currentNb|
  somme = somme + currentNb
end

puts somme