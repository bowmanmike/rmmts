class Notification < ActiveRecord::Base
  belongs_to :mate
  belongs_to :chore
end
