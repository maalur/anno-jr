class BrowsersController < ApplicationController
	before_action :signed_in_user, except: [:index, :info]
	before_action :correct_user,   only: :destroy

	def index
		@browsers = Browser.paginate(page: params[:page]) #replace with Browsers.permissions
	end

	def new
	end

	def create
		@browser = current_user.browsers.build(browser_params)
    if @browser.save
      flash[:success] = "New browser created!"
      redirect_to root_url
    else
    	@feed_items = []
      render 'static_pages/home'
    end
	end

	def show
	end

	def edit
	end

	def update
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
