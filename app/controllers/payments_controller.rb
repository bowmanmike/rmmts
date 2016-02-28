class PaymentsController < ApplicationController

  before_action :load_expense
  before_action :load_payment, only: [:show, :edit, :update, :destroy]

  def new
    @payment = Payment.new
  end

  def create
    @payment = @expense.payments.build(payment_params)

    if @payment.save
      redirect_to house_path(@expense)
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
  end

  def destroy
  end

  private

  def payment_params
    #code
  end

  def load_expense
    @expense = Expense.find(params[:expense_id])
  end

  def load_payment
    @payment = Payment.find(params[:id])
  end
end
