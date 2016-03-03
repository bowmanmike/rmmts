class PurchasesController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_mate
  before_action :load_purchase, only: [:show, :edit, :update, :destroy]

  def new
    @purchase = Purchase.new
  end

  def create
    @purchase = @mate.purchases.build(purchase_params)

    if @purchase.save
      redirect_to house_path(@house)
      flash[:notice] = "Purchase has been added!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @purchase.update_attributes(purchase_params)

    if @purchase.save
      redirect_to house_path(@house)
      flash[:notice] = "Purchase has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @purchase.destroy

    redirect_to house_path(@house)
    flash[:notice] = "Purchase has been deleted!"
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
end
