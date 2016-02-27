class SessionsController < ApplicationController

  def new
    @mate = Mate.new
  end

  def create
    if Mate.find_by(username: params[:login])
      params[:login] = Mate.find_by(username: params[:login]).email
    end

    if @mate = login(params[:login], params[:password])
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



# if params[:username] != "" && Mate.find_by(username: params[:username])
#   params[:email] = Mate.find_by(username: params[:username]).email
# end
