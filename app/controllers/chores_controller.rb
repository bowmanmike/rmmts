class ChoresController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_chore, only: [:show, :edit, :update, :destroy]

  def new
    @chore = Chore.new
  end

  def create
    @chore = @house.chores.build(chore_params)
    @chore.mate = nil
    @chore.creator = current_user
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
    if params[:chore][:assign_self]
      @chore.mate_id = params[:chore][:assign_self]
      @chore.save
      redirect_to :back, notice: "You have claimed this chore"
      return
    end



    if @chore.update_attributes(chore_params)
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
    @chore = Chore.find(params[:id])
  end

  def load_house
    @house = House.find(params[:house_id])
  end

  def chore_params
    params.require(:chore).permit(:name, :description, :due_date, :recurring, :frequency_unit, :frequency_integer, :complete)
  end

end
