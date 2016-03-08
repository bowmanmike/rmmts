class HousesController < ApplicationController
  before_action :load_announcements, only: [:show]
  before_action :load_chores, only: [:show]
  before_action :load_house, only: [:show, :edit, :update, :destroy]
  before_filter :must_be_logged_in, except: [:index]

  def index
    if current_user && current_user.house_id?
      redirect_to house_path(current_user.house)
    else
      @houses = House.all
    end
  end

  def show
    @purchases = @house.purchases
    @expenses = @house.expenses
    @announcement = @house.announcements.build

    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.creator_id = current_user.id

    if @house.save
      redirect_to house_path(@house.id), notice: "House created!"
    else
      render :new
    end
  end

  def edit
    respond_to do |format|
      format.html { render :edit }
      format.js {}
    end
  end

  def update
    if params[:username_search]
      if Mate.find_by(username: params[:username_search])
        @mate = Mate.find_by(username: params[:username_search])
        @house.mates << @mate
        MateMailer.join_house(@mate, @mate.house).deliver_later
        redirect_to :back, notice: "Mate added to house"
        return
      else
        redirect_to :back, notice: "Couldn't find a mate by that username"
        return
      end
    end

    if @house.update_attributes(house_params)
      redirect_to house_path(@house.id), notice: "House Updated!"
    else
      render :edit
    end
  end

  def destroy
    @house.destroy
    redirect_to houses_path
  end

  private

  def house_params
    params.require(:house).permit(:name, :house_image)
  end

  def load_announcements
    @announcements = House.find(params[:id]).announcements.order(created_at: :desc)
  end

  def load_house
    @house = House.find(params[:id])
  end

  def load_chores
    @chores = House.find(params[:id]).chores.order(due_date: :desc)
  end

end
