class PurchasesController < ApplicationController

  before_filter :require_login

  before_action :load_mate
  before_action :load_house, except: [:create, :update, :destroy]
  before_action :load_house_purchases, except: [:create, :update, :destroy]
  before_action :load_purchase, only: [:show, :edit, :update, :destroy]
  before_action :load_events, only: [:create, :update, :destroy]

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = @mate.purchases.build(purchase_params)
    @house = @purchase.house
    @purchases = @house.purchases

    respond_to do |format|
      if @purchase.save
        flash[:notice] = "Purchase successfully created."
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :new }
        format.js {}
      end
    end
  end

  def show
    respond_to do |format|
      format.html { render @purchase }
      format.js {}
    end
  end

  def edit
  end

  def update
    @house = @purchase.house
    @purchases = @house.purchases

    respond_to do |format|
      if @purchase.update_attributes(purchase_params)
        flash[:notice] = "Purchase has been updated!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    @house = @purchase.house
    @purchase.destroy
    @purchases = @house.purchases

    respond_to do |format|
      if @purchase.destroy
        flash[:notice] = "Purchase has been deleted!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :back }
        format.js {}
      end
    end
  end

  private

  def purchase_params
    params.require(:purchase).permit(:name, :description, :due_date, :amount, :image, :image_cache)
  end

  def load_purchase
    @purchase = Purchase.find(params[:id])
  end

  def load_mate
    @mate = current_user
  end

  def load_house
    @house = current_user.house
    # @house = @mate.house
  end

  def load_house_purchases
    @purchases = current_user.house.purchases
  end

  def load_events
    @house = current_user.house
    @events = @house.chores + @house.expenses + @house.purchases
  end
end
