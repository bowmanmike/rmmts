class HousesController < ApplicationController
  before_action :load_announcements, only: [:show]
  before_action :load_house, only: [:show, :edit, :update, :destroy]


  def index
    @houses = House.all
  end

  def show
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
  end

  def update
    if params[:username_search]
      if Mate.find_by(username: params[:username_search])
        @house.mates << Mate.find_by(username: params[:username_search])
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
    params.require(:house).permit(:name)
  end

  def load_announcements
    @announcements = House.find(params[:id]).announcements
  end

  def load_house
    @house = House.find(params[:id])
  end

end
