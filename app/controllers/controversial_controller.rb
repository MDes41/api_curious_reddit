class ControversialController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/controversial')
	end
end