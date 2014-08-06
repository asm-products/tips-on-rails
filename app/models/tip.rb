class Tip < ActiveRecord::Base
	extend FriendlyId
	friendly_id :title, use: [:slugged, :history]
	belongs_to :user, counter_cache: true
	has_many :bookmarks
	before_save :pygmentize_and_cache_body
	

	
	default_scope -> { order('created_at DESC') }
	validates :title, presence: true, length: {maximum: 50}
  validates :description, presence: true, length: { maximum: 250 }
  validates :user_id, presence: true

  def bookmarked_by(user=nil)
	  bookmarks.find_by(user_id: user.id) unless user == nil
	end

	def pygmentize_and_cache_body
		self.body_cached = MarkDownRenderer.new.pygmentize_and_render(body)
	end
	
	#def should_generate_new_friendly_id?
	#	new_record?
	#end
end
