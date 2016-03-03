class PaymentsController < ApplicationController

  before_filter :require_login

  before_action :load_mate
  before_action :load_purchase
  before_action :load_payment, only: [:show, :edit, :update, :destroy]

  def new
    @payment = Payment.new
  end

  def create
    @payment = @purchase.payments.build(payment_params)
    @payment.mate = current_user

    if @payment.save
      redirect_to mate_purchase_path(@mate, @purchase)
      flash[:notice] = "Thanks for your payment!"
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    @payment.update_attributes(payment_params)

    if @payment.save
      redirect_to mate_purchase_path(@mate, @purchase)
      flash[:notice] = "Payment has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy

    redirect_to mate_purchase_path(@mate, @purchase)
    flash[:notice] = "Payment has been deleted!"
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :paid_date)
  end

  def load_mate
    @mate = Mate.find(params[:mate_id])
  end

  def load_purchase
    @purchase = Purchase.find(params[:purchase_id])
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end
end
