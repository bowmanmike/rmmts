class PurchasesController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_mate
  before_action :load_house_purchases
  before_action :load_purchase, only: [:show, :edit, :update, :destroy]
  before_action :load_events, only: [:create, :update, :destroy]

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = @mate.purchases.build(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Purchase has been added!" }
        format.js {}
      else
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
    @purchase.update_attributes(purchase_params)

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Purchase has been updated!" }
        format.js {}
      else
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    @purchase.destroy

    respond_to do |format|
      if @purchase.destroy
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Purchase has been deleted!" }
        format.js {}
      else
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
  end

  def load_house_purchases
    @purchases = @house.purchases
  end

  def load_events
    @house = current_user.house
    @events = @house.chores + @house.expenses + @house.mates.purchases
  end
end
