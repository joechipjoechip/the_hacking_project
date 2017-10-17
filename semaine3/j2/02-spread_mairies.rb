require 'bundler'
Bundler.require
# require 'pry'
# require 'json'

# to start, use :
# bundle exec ruby 02-spread_mairies.rb

$spread_name = "mairies_france"

class Write_this

  attr_accessor :the_hash

  def initialize(my_hash)
    @big_hash = my_hash
    @ligne_start = 1
  end

  def session_init
    @session = GoogleDrive::Session.from_config("config.json")
  end

  def worksheet_init
    spreadsheet = @session.spreadsheet_by_title($spread_name)
    @worksheet = spreadsheet.worksheets.first
  end

  def write_init
    @big_hash.keys.each.with_index do |key_dep, index_dep|
      
      val1 = @big_hash.keys[index_dep]
      val2 = @big_hash[key_dep]["nom_departement"]
      
      @worksheet[@ligne_start, 1] = val1
      @worksheet[@ligne_start, 2] = val2
      finish

      @communes = @big_hash[key_dep]["communes"]

      @communes.keys.each.with_index do |key, index|

        write_a_line(key, @ligne_start)

        # save file every 10 entries
        if index % 10 == 0
          finish
        end
      end

      finish
    end
  end

  def write_a_line(key, index)
    @worksheet[index + 1, 1] = key

    if @communes[key].is_a?(Hash)
      if @communes[key].has_key? "email"
        @worksheet[index + 1, 2] = @communes[key]["email"]
      end
      if @communes[key].has_key? "maire"
        @worksheet[index + 1, 3] = @communes[key]["maire"]
      end
    end

    @ligne_start += 1
  end

  def finish
    @worksheet.save
  end

  def perform
    session_init
    worksheet_init
    write_init
  end

end


mon_json = File.read('output_mairies.json')
mon_hash = JSON.parse(mon_json)

my_instance = Write_this.new(mon_hash)

my_instance.perform
