class Admin::DashboardsController < ApplicationController
	helper_method :sort_column, :sort_direction

	def dashboards
		redirect_to root_path, alert: "Hey! That's off limits!" unless current_user && current_user.admin?
		
		@all_users = User.count
		@all_tips = Tip.count
		@all_bookmarks = Bookmark.count
		
		date = Date.today
		@selected_start_date = (date.at_beginning_of_week - 7.days).to_s
		@selected_end_date = (date.at_beginning_of_week - 1.day).to_s
		@weekly_tips = Tip.where(:created_at => @selected_start_date..@selected_end_date).count

		#find users who have more then 30 tips
		@most_active_users = User.where('tips_count >= ?', 30).count
		@more_active_users = User.where('tips_count BETWEEN 1 AND 29').count
		
		@list_most_active_users = User.where('tips_count >= ?', 30).limit(5)
		@list_more_active_users = User.where('tips_count BETWEEN 1 AND 29').limit(5)
	end

	def index
		redirect_to root_path, alert: "Hey! That's off limits!" unless current_user && current_user.admin?
		@all_users = User.count
		@users = User.order(sort_column + ' ' + sort_direction).paginate(:page => params[:page], :per_page => 20)
	end

	def weekly_stats
	# 	date = Date.today
	# 	@selected_start_date = (date.at_beginning_of_week).to_s
	# 	@selected_end_date = (date.at_beginning_of_week + 6.days).to_s
	# 	# @weekly_tips = Tip.where(:created_at => @selected_start_date..@selected_end_date).count
	# 	@other_tips = Tip.where(:created_at => @weeks).count
	# 	@all_tips = Tip.count
		@week = Tip.all 
		@tips = @week.group_by { |t| t.created_at.strftime("%U %B, %Y") }
	 # 	@weeks = (Date.parse("2014-08-04")..Date.parse("2014-12-30")).select(&:sunday?).map(&:to_s)
		# @weekly_tips = @weeks.each
	# @total_tips = User.where(:tips_count => @weekly_tips).size
	# Tip.where(created => start...end)
	end

	private

	def sort_column
		params[:sort] || "tips_count"
	end

	def sort_direction
		params[:direction] || "asc"
	end
end
