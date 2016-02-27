class House < ActiveRecord::Base
  belongs_to :creator, class_name: Mate
  has_many :chores
  has_many :mates

  validates :name, presence: true

end
