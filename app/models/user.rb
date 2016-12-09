class User < ApplicationRecord
	validates :username, presence: true
	
	def self.find_or_create_user(attrs)
		user = find_or_create_by(username: attrs[:username])
		user.access_token = attrs[:access_token]
		user.karma = attrs[:karma]
		user.save
		user
	end
end
