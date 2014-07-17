class TipsController < ApplicationController
	
	def index
		@tip = Tip.all
	end

	def show
		@tip = Tip.find(params[:id])
	end

	def new
		@tip = Tip.new
	end

	def create
    @tip = Tip.new(tip_params)
	end


	def edit
	end

	def update
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
end

