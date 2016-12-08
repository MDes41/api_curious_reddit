class GildedController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/gilded')
	end
end