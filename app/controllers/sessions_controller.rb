require "base64"
require 'base32'

class SessionsController < ApplicationController
	def new
		redirect_to "https://www.reddit.com/api/v1/authorize.compact?client_id=#{ENV['reddit_client_id']}&response_type=code&state=xxx&redirect_uri=http://127.0.0.1:3000/authorize&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread"
	end

	def create
		return redirect_to root_path if params[:error]

		conn = Faraday.new("https://www.reddit.com") 

		enc = Base64.encode64("#{ENV['reddit_client_id']}:#{ENV['reddit_client_secret']}").chomp
		enc2 = Base64.encode64("Aladdin:open sesame").chomp

		response = conn.post do |req|
			req.url '/api/v1/access_token'
			req.headers[:Authorization] = "Basic #{enc}"
			req.params[:grant_type] = 'authorization_code'
			req.params[:code] = params[:code]
			req.params[:redirect_uri] = 'http://127.0.0.1:3000/authorize'
		end

		json = JSON.parse(response.body, symbolize_names: true)

		conn2 = Faraday.new("https://oauth.reddit.com")

		response2 = conn2.get do |req|
			req.url '/api/v1/me'
			req.headers[:Authorization] = "bearer #{json[:access_token]}"
		end

		json2 = JSON.parse(response2.body, symbolize_names: true)

		user = User.find_or_create_by(username: json2[:name])
		user.access_token = json[:access_token]
		user.karma = json2[:link_karma]

		if user.save
			redirect_to dashboard_path
		else
			render :new
		end

		enc2 = Base64.encode64("Link").chomp
		byebug
		# <ActionController::Parameters {"state"=>"xxx", "code"=>"ZpCW1wK-xyvBLxmptcg1kmvMJpA", "controller"=>"sessions", "action"=>"create"} permitted: false>
		# <ActionController::Parameters {"state"=>"xxx", "error"=>"access_denied", "controller"=>"sessions", "action"=>"create"} permitted: false>
	end
end