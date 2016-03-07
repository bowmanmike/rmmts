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
    @mates = @expense.mates
  end

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update_attributes(expense_params)
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Expense has been updated!" }
        format.js {}
      else
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      if @expense.destroy
        format.html { redirect_to house_path(@house)
                      flash[:notice] = "Expense has been deleted!" }
        format.js {}
      else
        format.html { render :back }
        format.js {}
      end
    end
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
    params.require(:expense).permit(:name, :description, :amount, :paid, :due_date, :frequency_integer, :frequency_unit, :recurring, :frequency_weekday)
  end
end
