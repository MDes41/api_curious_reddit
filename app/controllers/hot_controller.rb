class HotController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/hot')
	end
end