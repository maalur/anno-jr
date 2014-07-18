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
		@json = get_json(@track)
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
		flash[:success] = "Track deleted."
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

		def get_json(track)
			colors = {"CG"=>"red", "CHG"=>"blue", "CHH"=>"green"}
			content = open("#{track.data}?action=range&assembly=1&left=700000&right=799999&bases=10&pixels=1").read
			data_hash = JSON[content]
			range = []
			bar_data = {"range"=>[0,0], "data"=>{"top"=>[], "bottom"=>[]}}

			data_hash['data'].each do |mc|
				mc[1].each do |set|
					range << set[0]
					bar_data["data"]["top"] <<  {"position"=>set[0],"value"=>set[2], "color"=>colors[mc[0]]} if set[2] > 0
					bar_data["data"]["bottom"] <<  {"position"=>set[0],"value"=>set[3], "color"=>colors[mc[0]]} if set[3] > 0
				end
			end

			bar_data["range"] = range.minmax
			bar_data.to_json
		end
end
