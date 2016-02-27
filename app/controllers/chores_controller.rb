class ChoresController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_chore, only: [:edit, :update, :destroy]

  def new
    @chore = Chore.new
  end

  def create
    @chore = @house.chores.build(chore_params)
    @chore.user = current_user
    @chore.complete = false

    if @chore.save
      redirect_to house_path(@house)
      flash[:notice] = "Chore has been added!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @chore.update_attributes(chore_params)

    if @chore.save
      redirect_to house_path(@house)
      flash[:notice] = "Chore has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @chore.destroy

    redirect_to house_path(@house)
    flash[:notice] = "Chore has been deleted!"
  end

  private

  def load_chore
    @chore = Chore.find(params:[id])
  end

  def load_house
    @house = House.find(params[:house_id])
  end

  def chore_params
    params.require(:chore).permit(:name, :description, :due_date, :frequency)
  end
end
