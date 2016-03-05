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
  has_many :notifications, dependent: :destroy

  has_many :sent_conversations, class_name: Conversation, foreign_key: 'sender_id'
  has_many :received_conversations, class_name: Conversation, foreign_key: 'receiver_id'
  has_many :sent_messages, through: :sent_conversations, class_name: Message
  has_many :received_messages, through: :received_conversations, class_name: Message
  has_many :messages

  has_many :payments
  has_many :purchases

  accepts_nested_attributes_for :notifications

  def conversations
    self.sent_conversations + self.received_conversations
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def owed_payments_sum
    sum = self.housemate_purchases.inject(0) do |sum, purchase|
      sum + purchase.amount_for_each
    end

    sum
  end

  def housemates
    housemates = self.house.mates.where.not(id: self.id)
  end

  def housemate_purchases
    housemate_purchases = self.house.purchases.where.not(mate_id: self.id)
  end

  def amount_owed_to(housemate)
    sum = housemate.purchases.inject(0) do |sum, purchase|
      sum + purchase.amount_owed_by(self)
    end

    sum
  end

  def assign_notifications
    self.house.chores.each do |chore|
      self.notifications.create(chore_id: chore.id, email: true, sms: false)
    end
  end

  def remove_notifications
    self.notifications.delete_all
  end

  def remove_notifications_on_claim(chore)
    other_mates = self.house.mates.where.not(id: self.id)
    other_mates.each do |mate|
      mate.notifications.where(chore_id: chore.id).delete_all
    end
  end
end
