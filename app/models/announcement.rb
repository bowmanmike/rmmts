class Announcement < ActiveRecord::Base
  validates :title, presence: true

  belongs_to :mate
  belongs_to :house
end
