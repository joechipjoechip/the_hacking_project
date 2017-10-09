def get_file_as_string(filename)
  data = ''
  f = File.open(filename, "r")

  f.each_line do |line|
    data += line
  end
  
  return data
end

mon_file_stringed = get_file_as_string("ascii.rb")

puts mon_file_stringed


# mon_file_stringed = get_file_as_string("ascii.rb").each_line do |line|
#   puts line + "and on"
# end