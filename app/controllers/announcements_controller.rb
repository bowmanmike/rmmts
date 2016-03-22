class AnnouncementsController < ApplicationController
  before_filter :require_login
  before_action :load_house, only: [:new, :create, :edit, :update, :destroy]
  before_action :load_house_announcements

  def index
  end

  def show
    @announcement = Announcement.find(params[:id])
  end

  def new
    @announcement = Announcement.new
  end

  def create
    @announcement = @house.announcements.build(announcement_params)
    if params[:anonymous]
      @announcement.mate_id = nil
    else
      @announcement.mate = current_user
    end

    respond_to do |format|
      if @announcement.save
        flash[:notice] = "Announcement added!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :new }
        format.js {}
      end
    end

  end

  def edit
    @announcement = Announcement.find(params[:id])
  end

  def update
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.update_attributes(announcement_params)
        format.html { redirect_to house_path(@announcement.house_id), notice: "Announcement updated" }
        format.js {}
      else
        format.html { render :edit }
        format.js {}
      end
    end

  end

  def destroy
    @announcement = Announcement.find(params[:id])

    respond_to do |format|
      if @announcement.destroy
        format.html { redirect_to house_path(params[:house_id]) }
        format.js {}
      else
        format.html { render :back }
        format.js {}
      end
    end
  end

  private
  def announcement_params
    params.require(:announcement).permit(:title, :body, :anonymous)
  end

  def load_house_announcements
    @announcements = Announcement.where(house_id: params[:house_id]).order(created_at: :DESC)
  end

  def load_house
    @house = House.find(params[:house_id])
  end

end
