class HousesController < ApplicationController
  before_action :load_announcements, only: [:show]
  before_action :load_chores, only: [:show]
  before_action :load_house, only: [:show, :edit, :update, :destroy]
  before_filter :must_be_logged_in, except: [:index]
  before_action :load_pending_invitations, only: [:show]
  before_action :load_events, only: [:show, :show_month_calendar]

  def housenames
    @houses = House.all
    respond_to do |format|
      format.json
    end
  end

  def index
    if current_user && current_user.house_id?
      redirect_to house_path(current_user.house)
    else
      if params[:search]
        @houses = House.where("name iLIKE ?", "%#{params[:search]}%")
      else
        @houses = House.all
      end
    end
  end

  def show
    @purchases = @house.purchases
    @chores = @house.chores.order(due_date: :asc)
    @expenses = @house.expenses.order(due_date: :asc)
    @announcement = @house.announcements.build

    respond_to do |format|
      format.html
      format.js
      format.json
    end
  end

  def new
    @house = House.new
  end

  def create
    @house = House.new(house_params)
    @house.creator_id = current_user.id
    current_user.house = @house
    current_user.save

    if @house.save
      redirect_to house_path(current_user.house), notice: "House created!"
    else
      render :new, alert: "Something went wrong. Please try again."
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
        @mate.assign_notifications
        @mate.create_conversations
        @mate.delete_pending_invites
        redirect_to :back, notice: "Mate added to house"
        return
      else
        redirect_to :back, alert: "Couldn't find a mate by that username"
        return
      end
    end

    if @house.update_attributes(house_params)
      redirect_to house_path(@house.id), notice: "House Updated!"
    else
      render :edit, alert: "Something went wrong. Please try again."
    end
  end

  def destroy
    if @house.destroy
      current_user.house_id = nil
      current_user.save
      redirect_to houses_path
      flash[:notice] = "House Successfully Deleted"
    else
      redirect_to house_path(@house)
      flash[:alert] = "There was a problem. House could not be deleted."
    end
  end

  def show_month_calendar
    @house = House.find(params[:house_id])
  end

  def stats
    @house = House.find(params[:house_id])
    respond_to do |format|
      format.html {}
      format.js {}
      format.json {}
    end
  end

  private

  def house_params
    params.require(:house).permit(:name, :house_image)
  end

  def load_announcements
    @announcements = House.find(params[:id]).announcements.order(created_at: :DESC)
  end

  def load_house
    @house = House.find(params[:id])
  end

  def load_chores
    @chores = House.find(params[:id]).chores.order(due_date: :desc)
  end

  def load_pending_invitations
    @pending_invitations = @house.pending_invitations
  end

  def load_events
    if @house
      @events = @house.chores + @house.expenses + @house.purchases
      @house.chores.where(recurring: true).each do |chore|
        chore.create_dummy_chores.each do |dummy|
          @events << dummy
        end
      end
      @house.expenses.where(recurring: true).each do |expense|
        expense.create_dummy_expenses.each do |dummy|
          @events << dummy
        end
      end
    else
      @house = House.find(params[:house_id])
      @events = @house.chores + @house.expenses + @house.purchases
      @house.chores.where(recurring: true).each do |chore|
        chore.create_dummy_chores.each do |dummy|
          @events << dummy
        end
      end
      @house.expenses.where(recurring: true).each do |expense|
        expense.create_dummy_expenses.each do |dummy|
          @events << dummy
        end
      end
    end
    @events
  end

end
