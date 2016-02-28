class Announcement < ActiveRecord::Base
  belongs_to :mate
  belongs_to :house
end
