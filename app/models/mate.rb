class Mate < ActiveRecord::Base
  authenticates_with_sorcery!
  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }

  belongs_to :house
  has_many :chores
  has_many :created_chores, class_name: Chore, foreign_key: 'creator_id'
  has_many :created_houses, class_name: House, foreign_key: 'creator_id'
  has_many :announcements
  has_many :sent_conversations, class_name: Conversation, foreign_key: 'sender_id'
  has_many :received_conversations, class_name: Conversation, foreign_key: 'receiver_id'
  has_many :sent_messages, through: :conversations, class_name: Message
  has_many :received_messages, through: :conversations, class_name: Message

  def conversations
    self.sent_conversations + self.received_conversations
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

end
