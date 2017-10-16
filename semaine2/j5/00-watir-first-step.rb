# http://intro-scrap-watir.surge.sh/
require 'watir'
require 'pry'

# browser = Watir::Browser.new
# if i wanna firefox :
browser = Watir::Browser.new(:firefox)

browser.goto 'google.com'

search_bar = browser.text_field(id: 'lst-ib')
search_bar.set('ouaip boiii')

# submit_button = browser.button(type: "submit")
# doesn't reach the target, but if we would
# submit_button.click

# div = browser.css(".jsb > input")
# binding.pry


browser.screenshot.save 'screenshot.png'

puts "new search please"
new_search = gets.chomp

search_bar.set(new_search)

search_bar.send_keys(:enter)

# browser.driver.manage.timeouts.implicit_wait = 3







