class TopController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/top')
	end
end