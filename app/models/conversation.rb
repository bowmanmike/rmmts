class Conversation < ActiveRecord::Base
  belongs_to :sender, class_name: Mate
  belongs_to :receiver, class_name: Mate

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :receiver_id

  scope :between, -> (sender_id, receiver_id) do
    where("(conversations.sender_id = ? && conversations.receiver_id = ?) || (conversations.sender_id = ? && conversations.receiver_id = ?)", sender_id, receiver_id, receiver_id, sender_id)
  end

end
