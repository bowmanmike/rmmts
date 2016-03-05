class ChoresController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_chore, only: [:show, :edit, :update, :destroy]

  after_action :check_notification_status, only: [:update]

  def new
    @chore = Chore.new
  end

  def create
    @chore = @house.chores.build(chore_params)
    @chore.mate = nil
    @chore.creator = current_user
    @chore.complete = false

    if @chore.save
      @chore.create_notifications
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
    params.require(:chore).permit(:name, :description, :due_date, :recurring, :complete,
                                  :frequency_unit, :frequency_integer, :frequency_weekday)
  end

  def check_notification_status
    @chore = Chore.find(params[:id])
    if @chore.check_claimed?
      @chore.mate.remove_notifications_on_claim(@chore)
    elsif !@chore.check_claimed?
      @chore.house.mates.where.not(id: current_user.id).each { |mate| mate.assign_notifications }
    end
  end

end
