class Mate < ActiveRecord::Base
  authenticates_with_sorcery!

  phony_normalize :phone_number, default_country_code: "CA"

  validates :username, presence: true, uniqueness: true
  validates :email, uniqueness: true
  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes["password"] }
  validates :password, confirmation: true, if: -> { new_record? || changes["password"] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes["password"] }
  validates :phone_number, phony_plausible: true

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
  has_many :expenses, through: :payments

  accepts_nested_attributes_for :notifications

  mount_uploader :mate_avatar, MateAvatarUploader

  def conversations
    self.sent_conversations + self.received_conversations
  end

  def create_conversations
    self.house.mates.where.not(id: self.id).each do |housemate|
      if Conversation.between(self.id, housemate.id).length == 0
        Conversation.create(sender_id: self.id, receiver_id: housemate.id)
      end
    end
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  def sum_owed_to_mates
    if self.house
      sum = self.housemate_purchases.inject(0) do |sum, purchase|
        sum + purchase.amount_for_each
      end

      sum
    end
  end

  def sum_owed_to_self
    if self.house
      sum = self.purchases.inject(0) do |sum, purchase|
        sum + purchase.amount_owed
      end

      sum
    end
  end

  def housemates
    housemates = self.house.mates.where.not(id: self.id)
  end

  def housemate_purchases
    if self.house
      housemate_purchases = self.house.purchases.where.not(mate_id: self.id)
    end
  end

  def amount_owed_to(housemate)
    if self.house
      sum = housemate.purchases.inject(0) do |sum, purchase|
        sum + purchase.amount_owed_by(self)
      end

      sum
    end
  end

  def expense_amount_paid(expense)
    if self.payments.where(expense_id: expense.id)
      self.payments.where(expense_id: expense.id, target_due_date: expense.due_date).sum(:amount)
    else
      0
    end
  end

  def assign_notifications
    self.house.chores.each do |chore|
      self.notifications.create(chore_id: chore.id, email: self.notify_email, sms: self.notify_sms)
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

  def update_all_notifications
    self.notifications.each do |notification|
      notification.email = self.notify_email
      notification.sms = self.notify_sms
      notification.save
    end
  end

end
