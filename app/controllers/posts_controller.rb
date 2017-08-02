class PostsController < ApplicationController
  
  # the user's queue of posts for the
  # upcoming two week period
  def index
    @posts = current_user.upcoming_posts(2)
  end

end