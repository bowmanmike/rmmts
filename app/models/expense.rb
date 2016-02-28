class Expense < ActiveRecord::Base
  belongs_to :house
  has_many :payments

  def amount_paid
    paid = self.payments.sum(:amount)
  end

  def amount_owed
    owed = self.amount - self.amount_paid
  end
end
