class NotificationsController < ApplicationController
  before_action :load_chore, only: [:index, :update]

  def index
    @notifications = current_user.notifications
  end

  def update
    @notification = Notification.find(params[:id])

    if @notification.update_attributes(notification_params)
      flash[:notice] = "Notification preferences updated"
      redirect_to house_path(@chore.house)
    else
      flash[:alert] = "There was a problem saving your notification preferences. Please try again."
      redirect_to house_path(@chore.house)
    end
  end

  def update_all
    if current_user.notifications.update_all(notification_params)
      flash[:notice] = "Global notification preferences updated!"
      redirect_to house_path(current_user.house)
    else
      flash[:alert] = "There was a problem saving your notification preferences. Please try again."
      redirect_to house_path(current_user.house)
    end
  end

  private

  def notification_params
    params.require(:notification).permit(:sms, :email)
  end

  def load_chore
    @chore = Notification.find(params[:id]).chore
  end

end
