class Tip < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_and_username, use: :slugged

  belongs_to :user, counter_cache: true
  has_many :bookmarks, dependent: :destroy
  before_save :pygmentize_and_cache_body

  default_scope -> { order('created_at DESC') }
  validates :title, presence: true, length: { maximum: 50 }
  validate :title_must_be_unique_for_user, on: :create
  validates :description, presence: true, length: { maximum: 250 }
  validates :body, presence: true
  validates :user_id, presence: true

  def bookmarked_by(user = nil)
    bookmarks.find_by(user_id: user.id) if user.present?
  end

  def pygmentize_and_cache_body
    self.body_cached = MarkDownRenderer.new.pygmentize_and_render(body)
  end

  def title_and_username
    "#{title} by #{user.username}"
  end

  def should_generate_new_friendly_id?
    if persisted?
      created_at < 1.day.ago
    else
      super
    end
  end

  def title_must_be_unique_for_user
    if Tip.exists?(slug: title_and_username.parameterize)
      errors.add(:title, "already exsits. Please change it")
    end
  end
end