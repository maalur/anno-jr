module BrowsersHelper

	def description
		@browser.description || "A description has not yet been added."
	end

	def citation
		@browser.citation || "A citation has not yet been added."
	end

	def data_download
		@browser.data_download || "Data download links have not yet been added."
	end
end
