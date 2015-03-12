    require './post'
    require './comment'
    require 'nokogiri'
    require 'open-uri'
    require 'colorize'
    require 'pry'


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
  doc.search('.title > a').map { |link| link['href']}[0]
end

def get_content(doc)
  doc.search('.comment > font:first-child').map { |font| font.inner_text}[0]
end

def create_post(doc)
  title = get_title(doc)
  id = get_id(doc)
  points = get_points(doc)
  link = get_link(doc)
  content = get_content(doc)
  comments = create_comments(doc)

  @newest_post = Post.new(title, id, points, link, content, comments)
end

def create_comments(doc)
  comments_list = []
  users = get_comments_users(doc)
  comments = get_comments_content(doc)
  times = get_comments_times(doc)
  length = users.length

  length.times do |i|
    comments_list << Comment.new(users[i], comments[i], times[i])
  end
  comments_list
end

def get_comments_times(doc)
  doc.css('.comhead > a:nth-child(2)').map{|user| user.inner_text} 
end

def get_comments_users(doc)
  doc.css('.comhead > a:first-child').map{|user| user.inner_text}
end

def get_comments_content(doc)
  doc.css('.comment').map{|user| user.inner_text}
end

def options
  puts "More Information Available | Choose from the following options:\n comments - show post comments\n  content - show full post content\n   newest - show most recent comment\n     exit - exit the program".colorize(:yellow)
end

def spacer
  puts "========================================================"
end

# doc = Nokogiri::HTML(File.open('post.html'))
def status(url)
  puts "Scraped: #{@url}".colorize(:green)
end

def goodbye
  puts "Thank you for using Scraper".colorize(:green)
end



def run
  @url = ARGV.shift
  @site =  open(@url)
  doc = Nokogiri::HTML(File.open(@site))

  create_post(doc)
  status(@url)
  spacer
  @newest_post.summary
  @scraping = true
  repl  
end

def repl
  while @scraping
    spacer
    options
    response = gets.chomp
    if response == 'comments'
      @newest_post.all_comments
    elsif response == 'content'
      @newest_post.show
    elsif response == 'newest'
      @newest_post.newest_comment
    elsif response == 'exit'
      goodbye
      @scraping = false 
    else
      puts "Not a valid option"
    end
  end
end

run
