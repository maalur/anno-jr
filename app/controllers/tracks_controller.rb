class TracksController < ApplicationController
	before_action :signed_in_user, except: [:index, :info]
	before_action :correct_user,   only: :destroy

	def index
		@tracks = Track.paginate(page: params[:page]) #replace with tracks.permissions
	end

	def new
		@track = Track.new
	end

	def create
		@track = current_user.tracks.build(track_params)
    if @track.save
      flash[:success] = "New track created!"
      redirect_to @track
    else
      render 'new'
    end
	end

	def show
		@track = Track.find(params[:id])
	end

	def edit
		@track = Track.find(params[:id])
	end

	def update
		@track = Track.find(params[:id])
		if @track.update_attributes(track_params)
      flash[:success] = "track updated"
      redirect_to @track
    else
      render 'edit'
    end
	end

	def destroy
		@track.destroy
    redirect_to root_url
	end

	def info
		@track = Track.find(params[:id])
	end

	private

		def track_params
			params.require(:track).permit([:name, :track_type, :path, :data])
		end

		def correct_user
      @track = current_user.tracks.find_by(id: params[:id])
      redirect_to root_url if @track.nil?
    end
end
