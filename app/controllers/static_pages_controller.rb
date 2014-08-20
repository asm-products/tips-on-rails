class StaticPagesController < ApplicationController

  def home
    @most_recent_tips = Tip.limit(5)
    @top_bookmarked_tips = Tip.unscoped.order(bookmarks_count: :desc).limit(5)
    @hide_default_logo = true unless current_user
    render layout: "home"
  end

  def help
  end

  def about
  end

  def contact
  end
end
