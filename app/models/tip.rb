class Tip < ActiveRecord::Base
  extend FriendlyId
  friendly_id :title_and_username, use: :slugged

  belongs_to :user, counter_cache: true
  has_many :bookmarks, dependent: :destroy
  before_save :pygmentize_and_cache_body
  before_save :check_tip_slugs

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

  def title_and_username
    "#{title} by #{user.username}"
  end

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end

  def check_tip_slugs
    @user = user
    user_tips = Tip.where(:user_id => @user.id)

    test_slug = title.parameterize
    tip_title = test_slug + ("-by-#{@user.username}").downcase

    user_tips.each do |tip|
      if tip_title == tip.slug
        return false
      end
    end
  end
end