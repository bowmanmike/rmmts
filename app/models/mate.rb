class Mate < ActiveRecord::Base
  authenticates_with_sorcery!
  belongs_to :house
  has_many :chores
  has_many :created_houses, class_name: House, foreign_key: 'creator_id'
end
