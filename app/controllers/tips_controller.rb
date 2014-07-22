class TipsController < ApplicationController
	before_filter :authenticate_user!, :except => [:show, :index]
	

	def index
		@tips = Tip.all
	end

	def show
		@tip = Tip.find(params[:id])
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
      render 'static_pages/home'
    end
  end

	def destroy
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
    # Use callbacks to share common setup or constraints between actions.
    def set_tip
      @tip = Tip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tip_params
      params.require(:tip).permit(:title, :description)
    end

    def correct_user
      @tip = current_user.tips.find_by(id: params[:id])
      redirect_to root_url if @tip.nil?
    end
end

