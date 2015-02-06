require 'rubygems'
require 'nokogiri'
require 'open-uri'
for n in 1..10
url = "http://myshows.me/search/all/?page="+n.to_s
doc = Nokogiri::HTML(open(url))
doc.css(".catalogTableSubHeader").each do |item|
	puts item.content
end
end
