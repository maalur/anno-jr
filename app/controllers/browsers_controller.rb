class BrowsersController < ApplicationController
	before_action :signed_in_user, except: [:index, :info]
	before_action :correct_user,   only: :destroy

	def index
		@browsers = Browser.paginate(page: params[:page]) #replace with Browsers.permissions
	end

	def new
		@browser = Browser.new
	end

	def create
		@browser = current_user.browsers.build(browser_params)
    if @browser.save
      flash[:success] = "New browser created!"
      redirect_to root_url
    else
      @browser_items = current_user.browser_feed
      @track = current_user.tracks.build
      @track_items = current_user.track_feed
      render 'static_pages/home'
    end
	end

	def show
	end

	def edit
		@browser = Browser.find(params[:id])
		@linked_tracks = @browser.linked_tracks.to_a
		@unlinked_tracks = current_user.tracks.to_a - @linked_tracks
	end

	def update
		@browser = Browser.find(params[:id])
		if @browser.update_attributes(browser_params)
      flash[:success] = "Browser updated"
      redirect_to info_browser_path(@browser)
    else
      render 'edit'
    end
	end

	def destroy
		@browser.destroy
    redirect_to root_url
	end

	def info
		@browser = Browser.find(params[:id])
	end

	private

		def browser_params
			params.require(:browser).permit(:name)
		end

		def correct_user
      @browser = current_user.browsers.find_by(id: params[:id])
      redirect_to root_url if @browser.nil?
    end
end
