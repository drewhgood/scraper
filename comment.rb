require'./post'
require 'rubygems'
require 'nokogiri'


class Comment

  attr_accessor :user, :time, :content

  def initialize(user, time, content) 
  @user = user
  @time = time
  @content = content
  #post_id = post it belongs to
  end




  

  # def create(parent_post)

  #  Comment.new

  # end



end

