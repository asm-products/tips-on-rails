class StaticPagesController < ApplicationController

  def home
    @most_recent_tips = Tip.limit(5)
    @top_bookmarked_tips = Tip.unscoped.order(bookmarks_count: :desc).limit(5)
  end

  def help
  end

  def about
  end

  def contact
  end
end
