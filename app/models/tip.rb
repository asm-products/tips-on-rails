class Tip < ActiveRecord::Base
	belongs_to :user
	has_many :bookmarks
	
	default_scope -> { order('created_at DESC') }
  validates :description, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def bookmarked_by(user)
	  bookmarks.find_by(user_id: user.id)
	end
end