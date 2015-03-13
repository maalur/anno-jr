module AnnojHelper
	require 'open-uri'

	def annoj_data(url, params)
  	annoj_params = params.select { |k,v| !['id', 'action', 'controller', 'format'].include?(k) }
  	annoj_params['action'] = params['action1']
		open(url + "?" + URI.encode_www_form(annoj_params)).read
	end

end