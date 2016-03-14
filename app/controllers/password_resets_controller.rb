class PasswordResetsController < ApplicationController
  skip_before_filter :require_login

  def index
    respond_to do |format|
      # format.html { render :edit }
      format.js {}
    end
  end

  def create
    @mate = Mate.find_by_email(params[:email])

    @mate.deliver_reset_password_instructions! if @mate

    redirect_to root_path, notice: "Instructions to reset your password have been sent via email."
  end

  def edit
    @token = params[:id]
    @mate = Mate.load_from_reset_password_token(params[:id])

    if @mate.blank?
      not_authenticated
      return
    end

  end

  def update
    @token = params[:id]
    @mate = Mate.load_from_reset_password_token(params[:id])

    if @mate.blank?
      not_authenticated
      return
    end

    @mate.password_confirmation = params[:mate][:password_confirmation]

    if @mate.change_password!(params[:mate][:password])
      redirect_to root_path, notice: "Password changed"
    else
      render :edit
    end
  end
end
