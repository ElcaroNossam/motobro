class PagesController < ApplicationController

  def home

  end

  def about
  end

  def otzuv 
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end
