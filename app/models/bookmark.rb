class Bookmark < ActiveRecord::Base
	belongs_to :tip
	belongs_to :user
end
