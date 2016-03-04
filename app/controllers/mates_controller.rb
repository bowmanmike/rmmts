class MatesController < ApplicationController
  before_action :load_mate, only: [:show, :edit, :update, :destroy]

  def index
    @mates = Mate.all
  end

  def show
    @purchases = @mate.purchases
    @housemate_purchases = @mate.housemate_purchases
  end

  def new
    @mate = Mate.new
  end

  def create
    @mate = Mate.new(mate_params)

    if @mate.save
      auto_login(@mate)
      MateMailer.welcome_email(@mate).deliver_later
      redirect_to mate_path(@mate), notice: 'account created'
    end
  end

  def edit
  end

  def update
    if @mate.update_attributes(mate_params)
      if @mate.house == nil
        @mate.chores = []
        redirect_to :back
      else
        MateMailer.join_house(@mate, @mate.house).deliver_later
        redirect_to house_path(@mate.house), notice: 'account updated'
      end
    else
      render :edit
    end
  end

  def destroy
    @mate.destroy
    redirect_to root_path, notice: 'account deleted'
  end

  private
  def mate_params
    params.require(:mate).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :house_id)
  end

  def load_mate
    @mate = Mate.find(params[:id])
  end

end
