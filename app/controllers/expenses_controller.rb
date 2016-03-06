class ExpensesController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_house_expenses
  before_action :load_expense, only: [:show, :edit, :update, :destroy]

  def new
    @expense = Expense.new
  end

  def create
    @expense = @house.expenses.build(expense_params)
    @expense.due_date = @expense.correct_weekday
    @expense.paid = false

    respond_to do |format|
      if @expense.save
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Expense has been added!" }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
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

  def load_expense
    @expense = Expense.find(params[:id])
  end

  def load_house
    @house = House.find(params[:house_id])
  end

  def load_house_expenses
    @expenses = @house.expenses
  end

  def expense_params
    params.require(:expense).permit(:name, :description, :amount, :paid, :due_date, :frequency_integer, :frequency_unit, :recurring)
  end
end
