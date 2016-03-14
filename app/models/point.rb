class Point < ActiveRecord::Base
  belongs_to :mate

  def point_attributes(item)
    self.name = item.name
    self.due_date = item.due_date
    self.completed_date = item.updated_at
    self.category = item.class.name.demodulize
    self.category_id = item.id

    case self.category
    when "Chore"
      self.amount = 3
    when "Expense"
      self.amount = 5
    when "Purchase"
      self.amount = 2
    else
      self.amount = 0
    end
  end

end
