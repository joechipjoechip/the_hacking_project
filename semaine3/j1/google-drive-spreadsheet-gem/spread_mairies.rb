require 'bundler'
Bundler.require

class Write_this

  attr_accessor :the_hash, :spread_name

  def initialize(my_hash, spread_name)
    @big_hash = my_hash
    @spread_name = spread_name
  end

  def session_init
    @session = GoogleDrive::Session.from_config("config.json")
  end

  def worksheet_init
    spreadsheet = @session.spreadsheet_by_title(@spread_name)
    @worksheet = spreadsheet.worksheets.first
  end

  def write_init
    @big_hash.keys.each.with_index do |key, index|
      write_a_line(key, index)
    end
    finish
  end

  def write_a_line(key, index)
    @worksheet[index + 1, 1] = @big_hash.keys[index]
    @worksheet[index + 1, 2] = @big_hash[key]["email"]
    @worksheet[index + 1, 3] = @big_hash[key]["referent"]
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

my_instance = Write_this.new(mon_hash, "test pour ruby gem")
my_instance.perform



