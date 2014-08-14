class TipsController < ApplicationController
  before_filter :authenticate_user!, except: [:show, :index]
  before_filter :set_tip, except: [:index, :new, :create]

  def index
    @tips = Tip.includes(:user).paginate(page: params[:page], per_page: 10)
  end

  def show
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
      render :new
    end
  end

  def edit
    redirect_to tip_path(@tip), alert: "That's not yours to edit!" unless can? :update, @tip
  end

  def update
    @tip = Tip.find(params[:id])
    if @tip.update_attributes(tip_params)
      flash[:notice] = "Successfully updated your tip."
      redirect_to @tip
    else
      render :edit
    end
  end

  def destroy
    redirect_to tip_path(@tip), alert: "That's not yours to delete!" unless can? :destroy, @tip
  end

  def send_destroy_email
    @delete = DeleteMailer.reason_to_delete(@tip, params[:message]).deliver
    redirect_to tips_path, notice: 'Thanks for your input!'
  end

private

  # Never trust parameters from the scary internet, only allow the white list through.
  def tip_params
    params.require(:tip).permit(:title, :description, :body)
  end

  def set_tip
    @tip = Tip.find(params[:id])
  end
end