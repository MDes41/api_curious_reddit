class Listing
	def initialize(response)
		@response = response
	end

	def title
		@response[:data][:title]
	end

	def thumbnail
		@response[:data][:thumbnail]
	end

	def author
		@response[:data][:author]
	end

	def kind
		@response[:kind]
	end

	def self.get_listings(token, url)
		RedditApi.new.get_listings(token, url)[:data][:children].map do |raw_listing|
			Listing.new(raw_listing)
		end
	end
end