class SessionsController < ApplicationController
	def new
		redirect_to "https://www.reddit.com/api/v1/authorize.compact?client_id=#{ENV['reddit_client_id']}&response_type=code&state=xxx&redirect_uri=http://127.0.0.1:3000/authorize&duration=permanent&scope=identity,edit,flair,history,modconfig,modflair,modlog,modposts,modwiki,mysubreddits,privatemessages,read,report,save,submit,subscribe,vote,wikiedit,wikiread"
	end

	def create
		return redirect_to root_path if params[:error]

		service ||= RedditApi.new
		token ||= service.get_token(params[:code])
		user_info ||= service.get_user_info(token[:access_token])

		if User.find_or_create_user(username: user_info[:name], access_token: token[:access_token], karma: user_info[:link_karma])
			session[:user_id] = User.find_by(username: user_info[:name]).id
			redirect_to dashboard_path
		else
			redirect_to root_path
		end
	end
end