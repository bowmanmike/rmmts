class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate

  validates :name, presence: true
  validates :frequency, numericality: {only_integer: true}
  
end
