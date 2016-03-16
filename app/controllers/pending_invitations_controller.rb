class PendingInvitationsController < ApplicationController

  def index
  end

  def create
    @mate = current_user
    @house = House.find(params[:house_id])
    @pending_invitation = @mate.pending_invitations.build
    @pending_invitation.house_id = @house.id

    if @pending_invitation.save
      @house.mates.each do |mate|
        MateMailer.request_to_join(@mate, @house, mate).deliver_later
      end
      flash[:notice] = "Your request has been sent!"
      redirect_to house_path(@house)
    else
      flash[:alert] = "There was a problem. Please try again."
      redirect_to house_path(@house)
    end

  end

  def update
  end

  def destroy
  end

end
