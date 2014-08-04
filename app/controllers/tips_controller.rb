class TipsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index, :create]
	
	def index
		@tips = Tip.paginate(:page => params[:page], :per_page => 30)
		 respond_to do |format|
    	format.html
    	format.json { render json: @tips }
  	end
	end

	def show
		@tip = Tip.find(params[:id])
		#place this here because you are showing a tip and need to know whether the user
		#has bookmarked a tip.
		@bookmark = @tip.bookmarked_by(current_user)
	end

	def new
		@tip = Tip.new
	end

	def create
   @tip = current_user.tips.build(tip_params)
    if @tip.save
      flash[:success] = "Tip created!"
      redirect_to @tip
    else
      render new
    end
  end

	def destroy
		@tip = Tip.find(params[:id])
		@tip.destroy
		redirect_to tips_path
	end

	def edit
		@tip = Tip.find(params[:id])
		
	end

	def update
		@tip = Tip.find(params[:id])
		if @tip.update_attributes(tip_params)
			flash[:notice] = "Successfully updated your tip."
			redirect_to @tip
		else
			render :action => 'edit'
		end
	end

private

    # Never trust parameters from the scary internet, only allow the white list through.
    def tip_params
      params.require(:tip).permit(:title, :description, :code, :references)
    end

    def correct_user
      @tip = current_user.tips.find_by(id: params[:id])
      redirect_to root_url if @tip.nil?
    end
end