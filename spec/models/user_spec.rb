require 'rails_helper'

RSpec.describe User, type: :model do
  	it { should validate_presence_of(:username) }
  context 'Find or create user' do
  	it 'returns true when user is created' do
  		user = User.create(username: 'Matt', karma: '1', access_token: 'xxx')
  		username = "Matt"
  		token = 'yyy'
  		response = User.find_or_create_user(username: username, access_token: token, karma: '2')

  		expect(response).to eq(true)
  		expect(User.all.count).to eq(1)
  		expect(User.first.access_token).to eq('yyy')
  		expect(User.first.karma).to eq('2')
  	end

  	it 'returns false when user is not created' do
  		username = nil
  		token = 'xxx'
  		karma = '1'
  		response = User.find_or_create_user(username: username, access_token: token, karma: karma)

  		expect(User.all.count).to eq(0)
  		expect(response).to eq(false)
  	end

  end
end
