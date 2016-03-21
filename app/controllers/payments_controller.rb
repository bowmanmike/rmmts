class PaymentsController < ApplicationController

  before_filter :require_login

  before_action :load_mate
  before_action :load_purchase
  before_action :load_expense
  before_action :load_house
  before_action :load_payment, only: [:show, :edit, :update, :destroy]
  before_action :load_purchases
  before_action :load_expenses

  # after_action :assign_points, only: [:create]

  def new
    @payment = Payment.new

    respond_to do |format|
      if params[:expense_id]
        format.html { render 'expense_payment_form' }
        format.js {}
      elsif params[:purchase_id]
        format.html { render 'purchase_payment_form' }
        format.js {}
      end
    end
  end

  def create
    if params[:mate_id] && params[:purchase_id]
      @payment = @purchase.payments.build(payment_params)
      @payment.mate = current_user
      @mate_purchases = current_user.purchases
    end

    if params[:house_id] && params[:expense_id]
      if @expense.is_paid?
        redirect_to house_expense_path(@house, @expense), notice: "This household expense is already fully paid"
        return
      end
      @payment = @expense.payments.build(payment_params)
      @payment.mate = current_user
      @payment.target_due_date = @expense.due_date
    end

    respond_to do |format|
      if @payment.save
        assign_points
        format.html do
          if params[:mate_id] && params[:purchase_id]
            redirect_to mate_purchase_path(@mate, @purchase)
            flash[:notice] = "Thanks for your payment!"
          elsif params[:house_id] && params[:expense_id]
            @expense.paid = true if @expense.is_paid?
            @expense.save
            redirect_to house_expense_path(@house, @expense)
            flash[:notice] = "Thanks for your payment!"
          end
        end
        format.js
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :new }
        format.js
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @payment.update_attributes(payment_params)
    @housemate_purchases = @mate.housemate_purchases
    if @payment.save
      redirect_to mate_path(@mate)
      flash[:notice] = "Payment has been updated!"
    else
      flash[:alert] = "Something went wrong. Please try again."
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

  def load_purchases
    @purchases = current_user.house.purchases
  end

  def load_expenses
    @expenses = current_user.house.expenses
  end

  def assign_points
    if @payment.expense_id != nil
      @expense = Expense.find(@payment.expense_id)
      Point.assign_points(@expense, @payment.mate)
    elsif @payment.purchase_id != nil
      @purchase = Purchase.find(@payment.purchase_id)
      Point.assign_points(@purchase, @payment.mate)
    end
  end
end
