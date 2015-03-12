class Comment
  attr_reader :user, :content, :time

  def initialize(user, content, time) 
  @user = user
  @content = content
  @time = time
  end

end

