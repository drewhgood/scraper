require'./comment'
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


class Post

  attr_accessor :title, :url, :points, :item_id

  def initialize(title, url, points, item_id)
    
    @url = url
    
    @points = points
    @item_id = points
    @title = title
    @comments_list = []
  end

  def add_comment(new_comments)
    @comments_list << new_comments
  end

  def comments

    # p @comments_list
    @comments_list.each do |comments|

      comments.each do |comment|
        p''
        p"#{comment.user} : #{comment.time}"
        p"----------------------------------"
        p comment.content
      end
      
    end

  end




 

end



