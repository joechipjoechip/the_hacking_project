require 'json'
require 'csv'

mon_json = File.read('google-drive-spreadsheet-gem/output_mairies.json')
# puts mon_json


mon_hash = JSON.parse(mon_json)
# puts mon_hash


CSV.open("mairies.csv", "wb") do |csv|
  
  first_line = []
  first_line << "ville"

  first_entry = mon_hash[mon_hash.keys[0]]

  first_line << first_entry.keys[0]
  first_line << first_entry.keys[1]

  csv << first_line

  mon_hash.keys.each.with_index do |key, index|
    line = []
    line << mon_hash.keys[index]
    line << mon_hash[key]["email"]
    line << mon_hash[key]["referent"]

    csv << line
  end
end