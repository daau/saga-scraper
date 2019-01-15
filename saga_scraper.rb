require "nokogiri"
require 'open-uri'
require "pry-byebug"

url = 'https://maplesaga.com/library/equip'
root_url = 'https://maplesaga.com/'
page = Nokogiri::HTML(open(url))
page.css('.container-fluid > .row > .row > a').each do |el|
    el.children[1].children[0].text.strip # Name of link
    puts el.attributes["href"].value # Relative url of link
end
puts "done"