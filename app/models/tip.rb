class Tip < ActiveRecord::Base
  belongs_to :user, counter_cache: true
  has_many :bookmarks, dependent: :destroy
  before_save :pygmentize_and_cache_body

  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }
  validates :body, presence: true
  validates :user_id, presence: true

  def bookmarked_by(user = nil)
    bookmarks.find_by(user_id: user.id) if user.present?
  end

  def pygmentize_and_cache_body
    self.body_cached = MarkDownRenderer.new.pygmentize_and_render(body)
  end
end
