class SessionsController < ApplicationController

  def new
    @mate = Mate.new
  end

  def create
    if @mate = login(params[:email], params[:password])
      redirect_to root_path, notice: "login successful"
    else
      render :new, notice: "login failed"
    end
  end

  def destroy
    logout
    redirect_to root_path, notice: "logged out"
  end

end
