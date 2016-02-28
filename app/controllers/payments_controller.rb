class PaymentsController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_expense
  before_action :load_payment, only: [:show, :edit, :update, :destroy]

  def new
    @payment = Payment.new
  end

  def create
    @payment = @expense.payments.build(payment_params)
    @payment.mate = current_user

    if @payment.save
      redirect_to house_expense_path(@house, @expense)
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
    @expense.update_attributes(expense_params)

    if @expense.save
      redirect_to house_path(@house)
      flash[:notice] = "Expense has been updated!"
    else
      render :edit
    end
  end

  def destroy
    @expense.destroy

    redirect_to house_path(@house)
    flash[:notice] = "Expense has been deleted!"
  end

  private

  def payment_params
    params.require(:payment).permit(:amount, :paid_date)
  end

  def load_house
    @house = House.find(params[:house_id])
  end

  def load_expense
    @expense = Expense.find(params[:expense_id])
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end
end
