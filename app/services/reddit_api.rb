class RedditApi 
	def initialize
		@conn = Faraday.new("https://www.reddit.com")
		@conn2 = Faraday.new("https://oauth.reddit.com")
		@auth = Base64.encode64("#{ENV['reddit_client_id']}:#{ENV['reddit_client_secret']}").chomp
	end

	def get_token(code)
		JSON.parse(token_response(code).body, symbolize_names: true)
	end

	def get_user_info(token)
		JSON.parse(user_info_response(token).body, symbolize_names: true)
	end

	def get_listings(token)
		JSON.parse(listings_response(token).body, symbolize_names: true)
	end

	def listings_response(token)
		conn2.get do |req|
			req.url '/hot'
			req.headers[:Authorization] = "bearer #{token}"
		end
	end

	def user_info_response(token)
		conn2.get do |req|
			req.url '/api/v1/me'
			req.headers[:Authorization] = "bearer #{token}"
		end
	end

	def token_response(code)
		conn.post do |req|
			req.url '/api/v1/access_token'
			req.headers[:Authorization] = "Basic #{@auth}"
			req.params[:grant_type] = 'authorization_code'
			req.params[:code] = code
			req.params[:redirect_uri] = 'http://127.0.0.1:3000/authorize'
		end
	end

	private
		attr_reader :conn, :auth, :conn2
end