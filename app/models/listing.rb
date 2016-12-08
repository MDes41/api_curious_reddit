class Listing
	def initialize(response)
		@response = response[:data]
	end

	def title
		@response[:title]
	end

	def thumbnail
		@response[:thumbnail]
	end

	def author
		@response[:author]
	end

	def self.get_listings(token)
		RedditApi.new.get_listings(token)[:data][:children].map do |raw_listing|
			Listing.new(raw_listing)
		end
	end
end