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

  def comments
    
  end

  def add_comment

  end
end



