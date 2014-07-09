class ViewsController < ApplicationController
  before_action :signed_in_user

  def create
    @track = Track.find(params[:view][:linked_id])
    @browser = Browser.find(params[:browser_id])
    @browser.link!(@track)
    redirect_to edit_browser_path(@browser)
  end

  def destroy
    @track = View.find(params[:id]).linked
    @browser = Browser.find(params[:browser_id])
    @browser.unlink!(@track)
    redirect_to edit_browser_path(@browser)
  end
end