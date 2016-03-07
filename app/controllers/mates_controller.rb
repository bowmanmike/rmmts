class MatesController < ApplicationController
  before_action :load_mate, only: [:show, :edit, :update, :destroy]
  before_action :load_mate_notifications, only: [:show]
  before_action :load_house, except: [:new, :create]

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
      redirect_to mate_path(@mate.id)
      flash[:notice] = 'account created'
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    if @mate.update_attributes(mate_params)
      if mate_params[:house_id].present?
        MateMailer.join_house(@mate, @mate.house).deliver_later
        @mate.assign_notifications
        redirect_to house_path(@mate.house), notice: 'account updated'
      elsif mate_params[:notify_sms] || mate_params[:notify_email]
        @mate.update_all_notifications
        redirect_to house_path(@mate.house)
      elsif mate_params[:house_id].blank?
        @mate.chores = []
        @mate.remove_notifications
        redirect_to root_path
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
    params.require(:mate).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation, :house_id, :phone_number, :notify_email, :notify_sms, :mate_avatar)
  end

  def load_mate
    @mate = Mate.find(params[:id])
  end

  def load_mate_notifications
    @notifications = Notification.where(mate_id: current_user.id)
  end

  def load_house
    @house = @mate.house
  end

end
