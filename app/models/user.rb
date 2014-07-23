class User < ActiveRecord::Base
	has_many :tips, dependent: :destroy
	before_save { self.email = email.downcase }

	validates :first_name, presence: true, length: { maximum: 50 }
	validates :last_name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
																		uniqueness: { case_sensitive: false }
	

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def name 
		[first_name, last_name].compact.join(' ')
	end
end
