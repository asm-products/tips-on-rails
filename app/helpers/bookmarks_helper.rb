module BookmarksHelper
  def bookmark_button(tip)
    render partial: 'bookmarks/button', locals: { tip: tip, current_user: current_user }
  end
end
