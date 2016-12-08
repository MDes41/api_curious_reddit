class NewController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/new')
	end
end