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

    respond_to do |format|
        if @mate = login(params[:login], params[:password])
          format.html { redirect_to root_path, notice: "login successful" }
          format.js {}
        else
          render :new, notice: "login failed"
        end
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
