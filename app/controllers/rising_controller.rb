class RisingController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/rising')
	end
end