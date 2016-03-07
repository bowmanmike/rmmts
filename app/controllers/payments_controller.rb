class PaymentsController < ApplicationController

  before_filter :require_login

  before_action :load_mate
  before_action :load_purchase
  before_action :load_expense
  before_action :load_house
  before_action :load_payment, only: [:show, :edit, :update, :destroy]

  def new
    @payment = Payment.new
  end

  def create
    if params[:mate_id] && params[:purchase_id]
      @payment = @purchase.payments.build(payment_params)
      @payment.mate = current_user
    end

    if params[:house_id] && params[:expense_id]
      @payment = @expense.payments.build(payment_params)
      @payment.mate = current_user
      @payment.target_due_date = @expense.due_date
    end

    if @payment.save
      if params[:mate_id] && params[:purchase_id]
        redirect_to mate_purchase_path(@mate, @purchase)
        flash[:notice] = "Thanks for your payment!"
      elsif params[:house_id] && params[:expense_id]
        @expense.paid = true if @expense.is_paid?
        @expense.save
        redirect_to house_expense_path(@house, @expense)
        flash[:notice] = "Thanks for your payment!"
      end
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
    if params[:mate_id]
      @mate = Mate.find(params[:mate_id])
    end
  end

  def load_purchase
    if params[:purchase_id]
      @purchase = Purchase.find(params[:purchase_id])
    end
  end

  def load_expense
    if params[:expense_id]
      @expense = Expense.find(params[:expense_id])
    end
  end

  def load_house
    if params[:house_id]
      @house = House.find(params[:house_id])
    end
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end
end
