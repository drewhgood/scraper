    require './post'
    require './comment'
    require 'nokogiri'
    require 'open-uri'
    require 'colorize'
    require 'pry'

doc = Nokogiri::HTML(File.open('post.html'))


def get_title(doc)
  string = doc.search('.title > a').map { |link| link.inner_text}
  s = string[0].to_s
  target = s.match('Show HN: Velocity.js \u00E2\u0080\u0093 ').to_s
  s.gsub(target, '')
end

def get_id(doc)
  doc.search('.subtext > a:nth-child(3)').map {|link| link['href'] }[0]
end

def get_points(doc)
  doc.search('.subtext > span:first-child').map { |span| span.inner_text}[0]
end

def get_link(doc)
  doc.search('.title > a').map { |link| link['href']}
end

def get_content(doc)
  doc.search('.comment > font:first-child').map { |font| font.inner_text}
end

def create_post(doc)
  title = get_title(doc)
  id = get_id(doc)
  points = get_points(doc)
  link = get_link(doc)
  content = get_content(doc)
  comments = create_comments(doc)

  @newby = Post.new(title, id, points, link, content, comments)
end

def create_comments(doc)
  comments_list = []
  users = get_comments_users(doc)
  comments = get_comments_content(doc)
  length = users.length

  length.times do |i|
    comments_list << Comment.new(users[i], comments[i])
  end
  comments_list
end


def get_comments_users(doc)
  doc.css('.comhead > a:first-child').map{|user| user.inner_text}
end

def get_comments_content(doc)
  doc.css('.comment').map{|user| user.inner_text}
end

create_post(doc)





# p doc.search('.comment > font:first-child').map { |font| font.inner_text}

