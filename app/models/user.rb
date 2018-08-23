class User < ApplicationRecord
	has_many :enrollments
	has_many :courses, :through => :enrollments
	has_many :friend_requests, dependent: :destroy
	has_many :pending_friends, :through => :friend_requests, :source => :friend
	has_many :friendships, dependent: :destroy
  	has_many :friends, through: :friendships

	before_save { self.email = email.downcase }
	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, length: { maximum: 255 },
	                    format: { with: VALID_EMAIL_REGEX },
	                    uniqueness: { case_sensitive: false }
	has_secure_password
	validates :password, presence: true, length: { minimum: 6 }

  	def remove_friend(friend)
    	current_user.friends.destroy(friend)
  	end

	def User.digest(string)
    	cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    	BCrypt::Password.create(string, cost: cost)
  	end
end
