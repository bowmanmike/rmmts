class HousesController < ApplicationController
  before_action :load_announcements, only: [:show]


  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
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
    @house = House.find(params[:id])
  end

  def update
    @house = House.find(params[:id])

    if @house.update_attributes(house_params)
      redirect_to house_path(@house.id), notice: "House Updated!"
    else
      render :edit
    end
  end

  def destroy
    @house = House.find(params[:id])
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

end
