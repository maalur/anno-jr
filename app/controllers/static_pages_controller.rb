class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @browser = current_user.browsers.build
      @feed_items = current_user.browser_feed.paginate(page: params[:page])
    end
  end

  def about
  end

  def help
  end

  def demo
  end

  def contact
  end
end
