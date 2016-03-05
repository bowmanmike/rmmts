class Expense < ActiveRecord::Base
  include Recurrence
  
  belongs_to :house
end
