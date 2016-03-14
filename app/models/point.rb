class Point < ActiveRecord::Base
  belongs_to :mate

  def point_attributes(item)
    self.name = item.name
    self.due_date = item.due_date
    self.completed_date = item.updated_at
    self.category = item.class.name.demodulize
    self.category_id = item.id

    if self.due_date.tomorrow.midnight >= self.completed_date
      case self.category
      when "Chore"
        self.amount = 3
        self.name = "Completed " + self.name
      when "Expense"
        self.amount = 5
        self.name = "Paid for " + self.name
      when "Purchase"
        self.amount = 2
        self.name = "Paid for " + self.name
      else
        self.amount = 0
      end
    else
      self.amount = 0
    end
  end

  def self.assign_points(item, mate)
    case item.class.name.demodulize
    when "Chore"
      @mate = Mate.find(item.mate_id)
      if item.complete
        Point.create_chore_point(item, @mate)
      else
        @point = Point.where(category_id: item.id, category: "Chore", mate_id: @mate.id, due_date: item.due_date).first
        if @point
          @point.destroy
        end
      end
    when "Expense"
      @mate = Mate.find(mate.id)
      if item.has_paid?(@mate)
        puts "Paid expense!"
        Point.create_expense_point(item, @mate)
      end
    when "Purchase"
      @mate = Mate.find(mate.id)
      if item.paid_by?(@mate)
        puts "Paid purchase!"
        Point.create_purchase_point(item, @mate)
      end
    end
  end

  def self.create_chore_point(chore, mate)
    @point = mate.points.build
    @point.point_attributes(chore)
    @point.save
  end

  def self.create_expense_point(expense, mate)
    # unless Point.where(mate_id: mate.id, category: "Expense", category_id: expense.id, due_date: expense.due_date)
      @point = mate.points.build
      @point.point_attributes(expense)
      @point.save
    # end
  end

  def self.create_purchase_point(purchase, mate)
    # unless Point.where(mate_id: mate.id, category: "Purchase", category_id: purchase.id, due_date: purchase.due_date)
      @point = mate.points.build
      @point.point_attributes(purchase)
      @point.save
    # end
  end

end
