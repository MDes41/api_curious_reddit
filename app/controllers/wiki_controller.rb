class WikiController < ApplicationController
	def index
		@listings = Listing.get_listings(current_user.access_token, '/wiki')
	end
end