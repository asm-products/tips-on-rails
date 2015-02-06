class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable,
  devise :trackable, :omniauthable, :omniauth_providers => [:github]

  has_many :tips, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  before_save { self.email = email.downcase }

  # validates :first_name, presence: true, length: { maximum: 50 }
  # validates :last_name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  
  # validates :password, presence: true, length: { minimum: 6 }, on: :create
  # validates :password_confirmation, presence: true, on: :update, allow_blank: true

  def name 
    [first_name, last_name].join(' ')
  end

  def bookmarked_tips
    tips.sum(:bookmarks_count, :group => :user_id)
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.username = auth.info.nickname
      user.password = Devise.friendly_token[0,20]
      user.first_name = auth.info.name.split(' ').first if user.first_name.blank?
      user.last_name = auth.info.name.split(' ').last if user.last_name.blank?
    end
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.github_data"]["info"]
        user.email = data["email"] if user.email.blank?
        user.first_name = data["name"].split(' ')[0] if user.first_name.blank?
        user.last_name = data["name"].split(' ')[1] if user.last_name.blank?
      end
    end
  end
end
