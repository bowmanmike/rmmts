class Expense < ActiveRecord::Base
  belongs_to :house
  has_many :expenses
end
