class StaticPagesController < ApplicationController
  def home
    if signed_in?
      @browser = current_user.browsers.build
      @browser_items = current_user.browser_feed
      @track = current_user.tracks.build
      @track_items = current_user.track_feed
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
