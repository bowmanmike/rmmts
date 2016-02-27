class HouseController < ApplicationController

  def new
    @house = House.new
  end

  def create
  end

  def index
    @houses = House.all
  end

  def show
    @house = House.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
