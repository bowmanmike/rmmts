class SessionsController < ApplicationController

  def new
    respond_to do |format|
      format.html { @mate = Mate.new }
      format.js
    end
  end

  def create

    if Mate.find_by(username: params[:login])
      params[:login] = Mate.find_by(username: params[:login]).email
    end

    if @mate = login(params[:login], params[:password], params[:remember])
      if @mate.house_id.present?
        redirect_to house_path(@mate.house), notice: "Login Successful!"
      else
        redirect_to houses_path, notice: "Login successful"
      end
    else
      render :new, alert: "Login failed"
    end
  end

  def destroy
    logout
    redirect_to houses_path, notice: "logged out"
  end

end



# if params[:username] != "" && Mate.find_by(username: params[:username])
#   params[:email] = Mate.find_by(username: params[:username]).email
# end
