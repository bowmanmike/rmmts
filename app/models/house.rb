class House < ActiveRecord::Base
  belongs_to :creator, class_name: Mate
  has_many :chores
  has_many :expenses
  has_many :mates
  has_many :purchases, through: :mates
  has_many :announcements

  validates :name, presence: true

end
