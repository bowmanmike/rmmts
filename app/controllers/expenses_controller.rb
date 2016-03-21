class ExpensesController < ApplicationController

  before_filter :require_login

  before_action :load_house
  before_action :load_house_expenses
  before_action :load_expense, only: [:show, :edit, :update, :destroy]
  before_action :load_events, only: [:create, :update, :destroy]

  def new
    @expense = Expense.new
  end

  def create
    @expense = @house.expenses.build(expense_params)
    @expense.due_date = @expense.correct_weekday
    @expense.paid = false

    respond_to do |format|
      if @expense.save
        @events << @expense
        flash[:notice] = "Expense successfully created!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :new }
        format.js {}
      end
    end
  end

  def show
    @mates = @expense.mates

    respond_to do |format|
      format.html { render @expense }
      format.js {}
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @expense.update_attributes(expense_params)
        @events << @expense
        flash[:notice] = "Expense successfully updated!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
        format.html { render :edit }
        format.js {}
      end
    end
  end

  def destroy
    @expense.destroy

    respond_to do |format|
      if @expense.destroy
        flash[:notice] = "Expense successfully deleted!"
        format.html { redirect_to house_path(@house) }
        format.js {}
      else
        flash[:alert] = "Something went wrong. Please try again."
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

  def load_events
    if @house
      @events = @house.chores + @house.expenses + @house.purchases
    else
      @house = House.find(params[:house_id])
      @events = @house.chores + @house.expenses + @house.purchases
    end
  end

end
