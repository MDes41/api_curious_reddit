class PromotedController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/promoted')
	end
end