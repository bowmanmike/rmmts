class Mate < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates_length_of :password, minimum: 3, message: "password must be at least 3 characters long", if: :password
  validates_confirmation_of :password, message: "should match confirmation", if: :password

  belongs_to :house
  has_many :chores
  has_many :created_houses, class_name: House, foreign_key: 'creator_id'
end
