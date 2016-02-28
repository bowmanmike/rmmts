class ExpensesController < ApplicationController

  before_action :load_house

  def new
    @expense = Expense.new
  end

  def create
    @expense = @house.expenses.build(expense_params)

    if @expense.save
      redirect_to house_path(@house)
      flash[:notice] = "Expense has been added!"
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

  def expense_params
    params.require(:expense).permit(:name, :description, :due_date, :amount)
  end

  def load_house
    @house = House.find(params[:house_id])
  end
end
