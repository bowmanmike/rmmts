class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate
end
