class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	has_many :tips, dependent: :destroy

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
																		uniqueness: { case_sensitive: false }
	has_secure_password
	

	def full_name
  	[first_name, last_name].join(' ')
	end

	def full_name=(name)
  	split = name.split(' ', 2)
  	self.first_name = split.first
  	self.last_name = split.last
	end


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
