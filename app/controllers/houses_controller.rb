class HousesController < ApplicationController

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
      redirect_to house_path(@house), notice: "House created!"
    else
      render :new
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
  def house_params
    params.require(:house).permit(:name)
  end

end
