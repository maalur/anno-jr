module TracksHelper

	def track_success?
		@info['success']
	end

	def track_title
		@info['data']['service']['title']
	end

	def track_description
		@info['data']['service']['description']
	end

	def track_species
		@info['data']['service']['species']
	end

	def track_provider
		@info['data']['institution']
	end

	def track_contact
		@info['data']['engineer']
	end
	
end
