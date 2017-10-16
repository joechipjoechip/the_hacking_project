require 'watir'



class Google_search

  attr_accessor :your_query

  def initialize(query)
    @your_query = query
    @@browser = Watir::Browser.new(:firefox)
  end

  def goto_google
    # OPEN BROWSER
    @@browser.goto 'google.com'
  end

  def google_bar
    # SELECT SEARCH BAR
    @search_bar = @@browser.text_field(class: 'gsfi')
  end

  def query
    # QUERY
    @search_bar.set(@your_query)
  end

  def enter_query
    # SEND QUERY WITH ENTER
    @search_bar.send_keys(:enter)
  end

  def click_query
    # SEND QUERY WITH CLICK
    @submit_button = @@browser.button(type:"submit")
    @submit_button.click
  end

  def perform
    goto_google
    google_bar
    query
    enter_query
  end

end

puts "you query please"
terminal_query = gets.chomp.to_s

if terminal_query
  search = Google_search.new(terminal_query)
  search.perform
end




