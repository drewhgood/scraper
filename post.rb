class Post
  attr_reader :title, :link, :points, :content, :id, :comments

  def initialize(title, id, points, link, content, comments)
    @title = title
    @link = link
    @points = points
    @id = id
    @content = content
    @comments = comments
  end

  def summary
    puts "#{title} : #{points}\n#{comments.length} comments\n#{link}".colorize(:blue)
  end

  def show
    spacer
    summary
    puts "\n#{content}"
  end

  def spacer
    puts "========================================================"
  end

  def all_comments
    comments.length.times do |i|
      spacer
      puts "User: #{comments[i].user}".colorize(:red)
      puts "Posted: #{comments[i].time}".colorize(:blue)
      puts "#{comments[i].content}"
    end
  end

end



