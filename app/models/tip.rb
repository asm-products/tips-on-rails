class Tip < ActiveRecord::Base
	belongs_to :user
	has_many :bookmarks
	before_save :pygmentize_code

	
	default_scope -> { order('created_at DESC') }
  validates :description, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true

  def bookmarked_by(user=nil)
	  bookmarks.find_by(user_id: user.id) unless user == nil
	end

	def pygmentize_code
		MarkDownRenderer.new.render_down
	end
end



