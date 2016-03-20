class PendingInvitationsController < ApplicationController

  def create
    @mate = current_user
    @house = House.find(params[:house_id])
    @pending_invitation = @mate.pending_invitations.build
    @pending_invitation.house_id = @house.id

    if @pending_invitation.save
      @house.mates.each do |mate|
        MateMailer.request_to_join(@mate, @house, mate).deliver_later
      end
      redirect_to house_path(@house)
      flash[:notice] = "Your request has been sent!"
    else
      redirect_to house_path(@house)
      flash[:alert] = "There was a problem. Please try again."
    end

  end

  def destroy
    @pending_invitation = PendingInvitation.find(params[:id])
    @mate = @pending_invitation.mate
    @house = @pending_invitation.house

    if @pending_invitation.destroy
      flash[:notice] = "Invitation rejected."
      MateMailer.invitation_rejected(@mate, @house).deliver_later
    end
  end
end
