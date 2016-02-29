class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :mate

  validates_presence_of :body, :conversation_id, :mate_id

  def message_time
    created_at.strftime('%A, %d %b at %Y %l:%M %p')
  end
end
