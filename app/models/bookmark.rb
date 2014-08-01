class Bookmark < ActiveRecord::Base
	belongs_to :tip, counter_cache: true
	belongs_to :user, counter_cache: true
end
