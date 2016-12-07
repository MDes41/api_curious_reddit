require "base64"

class SessionsController < ApplicationController
	def new
		# url = "https://www.reddit.com/api/v1/authorize.compact"
		# redirect_to(url, { client_id: ENV['reddit_client_id'],
		# 															response_type: 'code',
		# 															state: 'xxx',
		# 															redirect_uri: 'http://127.0.0.1:3000/authorize',
		# 															duration: 'permanent',
		# 															scope: 'identity'
		# 														})
														
		redirect_to "https://www.reddit.com/api/v1/authorize.compact?client_id=#{ENV['reddit_client_id']}&response_type=code&state=xxx&redirect_uri=http://127.0.0.1:3000/authorize&duration=permanent&scope=identity"
	end

	def create
		# byebug
		return redirect_to root_path if params[:error]
		#check other errors and make a flash message or and check state as well
		# byebug
		conn = Faraday.new("https://www.reddit.com") 
		# do |faraday|
		# 	faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
		# end

		enc = Base64.encode64("#{ENV['reddit_client_id']}:#{ENV['reddit_client_secret']}").chomp
		enc2 = Base64.encode64("Aladdin:open sesame").chomp

		hi = conn.post do |req|
			req.url '/api/v1/access_token'
			req.headers[:Authorization] = "Basic #{enc}"
			req.params[:grant_type] = 'authorization_code'
			req.params[:code] = params[:code]
			req.params[:redirect_uri] = 'http://127.0.0.1:3000/authorize'
		end

		json = JSON.parse(hi.body)
		byebug
		# <ActionController::Parameters {"state"=>"xxx", "code"=>"ZpCW1wK-xyvBLxmptcg1kmvMJpA", "controller"=>"sessions", "action"=>"create"} permitted: false>
		# <ActionController::Parameters {"state"=>"xxx", "error"=>"access_denied", "controller"=>"sessions", "action"=>"create"} permitted: false>
	end
end