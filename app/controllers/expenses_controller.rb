class ExpensesController < ApplicationController

  before_action :load_house

  def new
    @expense = Expense.new
  end

  def create
    @expense = @house.expenses.build(expense_params)

    if @expense.save
      redirect_to house_path(@house)
    else
      render :new
    end
  end

  def show
    #code
  end

  def edit
    #code
  end

  def update
    #code
  end

  def destroy
    #code
  end

  private

  def expense_params
    params.require(:expense).permit(:name, :description, :amount, :paid, :due_date, :frequency_integer, :frequency_unit, :recurring)
  end

  def load_house
    @house = House.find(params[:house_id])
  end

end
