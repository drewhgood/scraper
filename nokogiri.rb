
require 'rubygems'
require 'nokogiri'
require 'open-uri'  

#to open a remote url | Nokogiri::HTML(open("http://en.wikipedia.org/"))
#to targert specific css element. example targets only title tags | post.css('title')
#target specific instace of element by index | post.css('li')[0]
#target specific url | post.css('li')[1]['href']
#target div by id | post.css('div#funstuff')
#target nested elements |  page.css('div#reference a')
# use .text to output only what is found between the tags


post = Nokogiri::HTML(open("post.html"))   
puts post