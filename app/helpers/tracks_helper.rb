module TracksHelper
	require 'open-uri'

	def get_json(track)
		case track.track_type
		when "MethTrack"
			meth_track(track.data)
		else
			{"success"=>false,"range"=>[0,0], "data"=>{"top"=>[], "bottom"=>[]}}.to_json
		end
		
	end

	def meth_track(url)
		colors = {"CG"=>"red", "CHG"=>"blue", "CHH"=>"green"}
		range = []
		bar_data = {"success"=>false,"range"=>[0,0], "data"=>{"top"=>[], "bottom"=>[]}}

		begin
			content = open("#{url}?action=range&assembly=1&left=700000&right=799999&bases=10&pixels=1").read
			data_hash = JSON[content]
			bar_data["success"] = data_hash["success"]

			data_hash['data'].each do |mc|
				mc[1].each do |set|
					range << set[0]
					bar_data["data"]["top"] <<  {"position"=>set[0],"value"=>set[2], "color"=>colors[mc[0]]} if set[2] > 0
					bar_data["data"]["bottom"] <<  {"position"=>set[0],"value"=>set[3], "color"=>colors[mc[0]]} if set[3] > 0
				end
			end

			bar_data["range"] = range.minmax
		rescue OpenURI::HTTPError => ex
			bar_data["success"] = false
		end

		bar_data.to_json
	end

	def reads_track
	end

end
