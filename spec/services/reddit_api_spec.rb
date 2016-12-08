require 'rails_helper'

describe 'Reddit Token' do
	context 'makes a api call' do
		it 'returns the token' do
			VCR.use_cassette("token_request") do

				code = ENV['reddit_code']

				response = RedditApi.new.get_token(code)
				expect(response).to be_a(Hash)
				expect(response).to have_key(:access_token)
				expect(response).to have_key(:token_type)
				expect(response).to have_key(:expires_in)
				expect(response).to have_key(:refresh_token)
			end
		end

		it 'gets user info' do
			VCR.use_cassette("user_info") do
				response = RedditApi.new.get_user_info(ENV['reddit_token'])

				expect(response).to be_a(Hash)
				expect(response).to have_key(:name)
				expect(response).to have_key(:created)
				expect(response).to have_key(:link_karma)
			end	
		end

		it 'gets listing back for whats hot' do
			VCR.use_cassette('listings') do
				response = RedditApi.new.get_listings(ENV['reddit_token'], '/hot')

				expect(response).to be_a(Hash)
				expect(response).to have_key(:kind)
				expect(response).to have_key(:data)
				expect(response[:data]).to have_key(:children)
				expect(response[:data][:children]).to be_a(Array)
			end
		end
	end
end
