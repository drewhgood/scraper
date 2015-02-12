require './post'
require './comment'
require 'nokogiri'
require 'open-uri'

  def capture(doc)
    # url = doc.search('.subtext > span:first-child').map { |span| span.inner_text}
    # points =  doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }
    # title = doc.search('.title > a:first-child').map { |link| link.inner_text}
    # item_id = doc.search('.title > a:first-child').map { |link| link['href']}
    
    # new_post = Post.new(title, url, points, item_id)
    # p new_post.comments_list = get_coments(doc)

    # @url  = url
    @points = get_points(doc)
    @item_id = get_item_id
    @title = get_title(doc) 
    @new_post = Post.new(@title, @item_id, @points, @item_id)
    all_c = get_comments(doc) 
    @new_post.comments  << all_c

    @new_post.comments

  end

  
  def get_points(doc)
    doc.css('span.score').text
  end
  


  def get_item_id()
    id = 'https://news.ycombinator.com/item?id=7663775'.scan(/(\d.+)/)
    #will be passed via url when file not local
  end



  def get_title(doc)
     doc.search('.title > a:first-child').map { |link| link.inner_text}
  end



  def get_users(doc)
    doc.css('.comhead > a:first-child').map{|user| user.inner_text}

  end



  def get_times(doc)
    doc.css('.comhead > a:nth-child(2)').map{|user| user.inner_text} 
  end



  def get_content(doc)
    doc.search('.comment > font:first-child').map { |font| font.inner_text}
  end



  def get_comments(doc)
    comments = []
    user = get_users(doc)
    time = get_times(doc)
    content = get_content(doc)

    l = user.length 
    
    l.times do |i|
    comments << Comment.new(user[i], time[i], content[i])
    end
    comments
  end


  p @url = ARGV[0]
  p @site =  open(@url)
  doc = Nokogiri::HTML(File.open(@site))

  capture(doc)










