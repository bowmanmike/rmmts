class ChoresController < ApplicationController
  before_filter :require_login

  before_action :load_house
  before_action :load_house_chores
  before_action :load_chore, only: [:show, :edit, :update, :destroy]
  before_action :load_events, only: [:create, :update, :destroy]

  after_action :check_notification_status, only: [:update]

  def new
    @chore = Chore.new
  end

  def create
    @chore = @house.chores.build(chore_params)
    @chore.due_date = @chore.correct_weekday
    @chore.mate = nil
    @chore.creator = current_user
    @chore.complete = false
    if @chore.reassignment_style == "random"
      @chore.mate_id = @chore.house.mates.sample.id
    elsif @chore.reassignment_style == "rotating"
      @chore.mate_id = current_user.id
    end

    respond_to do |format|
      if @chore.save
        @events << @chore
        flash[:notice] = "Chore has been added!"
         @chore.create_notifications
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "There was a problem creating your chore. Please try again."
        format.html { render :new }
        format.js {}
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render @chore }
      format.js {}
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if params[:chore][:assign_self]
        @chore.mate_id = params[:chore][:assign_self]
        @chore.save
        flash[:notice] = "You've claimed this chore!" if @chore.mate_id?
        flash[:notice] = "You've unclaimed this chore!" if !@chore.mate_id?
        format.html { redirect_to :back, notice: "You have claimed this chore" }
        format.js {}
        return
      end

      if @chore.update_attributes(chore_params)
        flash[:notice] = "Chore has been updated!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong! Please try again."
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    respond_to do |format|
      if @chore.notifications.destroy_all && @chore.destroy
        flash[:notice] = "Chore has been deleted!"
        format.html { redirect_to house_path(@house) }
        format.js{}
      else
        flash[:alert] = "Something went wrong! Please try again!"
        format.html { render :back }
        format.js {}
      end
    end
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
                                  :frequency_unit, :frequency_integer, :frequency_weekday,
                                  :reassignment_style)
  end

  def load_house_chores
    @chores = House.find(params[:house_id]).chores
  end

  def check_notification_status
    @chore = Chore.find(params[:id])
    if @chore.check_claimed?
      @chore.mate.remove_notifications_on_claim(@chore)
    elsif !@chore.check_claimed?
      @chore.house.mates.where.not(id: current_user.id).each { |mate| mate.assign_notifications }
    end
  end

  def load_events
    if @house
      @events = @house.chores + @house.expenses + @house.purchases
    else
      @house = House.find(params[:house_id])
      @events = @house.chores + @house.expenses + @house.purchases
    end
  end

end
