require 'rubygems'
require 'nokogiri'
require 'open-uri'

links = [
	"http://en.wikipedia.org/wiki/List_of_philosophers_%28A%E2%80%93C%29",
	"http://en.wikipedia.org/wiki/List_of_philosophers_%28D%E2%80%93H%29",
	"http://en.wikipedia.org/wiki/List_of_philosophers_%28I%E2%80%93Q%29",
	"http://en.wikipedia.org/wiki/List_of_philosophers_%28R%E2%80%93Z%29",
]

names = []
lengths = []

links.each do |link|
  page = Nokogiri::HTML(open(link))   
  page.css("div#mw-content-text ul li a").each do |a|
    if a.text.length > 1
      names.push([a.text, a["href"]])
      lengths.push(a.text.length)
    end
  end
end

names = names[5..-1] # first few aren't real

puts names.length.to_s + " possible cultural revolutionary movements detected."

File.open("names.txt", 'w') do |f|
    names.each do |(name, url)|
      f.write(name)
      f.write(",")
      f.write("http://en.wikipedia.org" + url)
      f.write("\n")
    end
end

max = lengths.max

url_length = 22

# two urls and two spaces, one before each url
tweet_length = (140 - max - (url_length * 2) - 2)

puts "Keep tweets less than #{tweet_length} characters so the alarm can be raised effectively!"
