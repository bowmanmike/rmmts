class Payment < ActiveRecord::Base
  belongs_to :mate
  belongs_to :purchase
  belongs_to :expense
end
