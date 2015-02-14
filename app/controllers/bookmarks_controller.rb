class BookmarksController < ApplicationController
  def create
    tip_id = params[:tip_id]
    current_user.bookmarks.create(tip_id: tip_id)
    redirect_to tip_path(tip_id)
  end

  def destroy
    # I want to unbookmark a current bookmarked item.
    @bookmark = Bookmark.find(params[:id])
    @bookmark.destroy
    redirect_to tip_path(@bookmark.tip)
  end
end
