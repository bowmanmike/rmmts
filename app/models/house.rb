class House < ActiveRecord::Base
  belongs_to :creator, class_name: Mate
  has_many :chores
  has_many :mates
  has_many :expenses

  validates :name, presence: true

end
