class House < ActiveRecord::Base
  belongs_to :creator, class_name: Mate
  has_many :chores, dependent: :destroy
  has_many :expenses
  has_many :mates
  has_many :purchases, through: :mates
  has_many :points, through: :mates
  has_many :announcements, dependent: :destroy
  has_many :pending_invitations, dependent: :destroy

  validates :name, presence: true

  before_destroy :check_occupancy

  mount_uploader :house_image, HouseImageUploader

  def check_occupancy
    if self.mates.count > 1
      return false
    end
  end

end
