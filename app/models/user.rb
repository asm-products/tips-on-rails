class User < ActiveRecord::Base
	extend FriendlyId
	friendly_id :last_name

	has_many :tips, dependent: :destroy
	has_many :bookmarks

	before_save { self.email = email.downcase }

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
																		uniqueness: { case_sensitive: false }
	
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true
  validates :bio, presence: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name 
		[first_name, last_name].compact.join(' ')
	end

	def bookmarked_tips
		tips.sum(:bookmarks_count, :group => :user_id)
	end
end
