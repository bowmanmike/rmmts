class PendingInvitation < ActiveRecord::Base
  belongs_to :mate
  belongs_to :house

  before_save :mate_has_no_other_requests

  def mate_has_no_other_requests
    mate = self.mate
    return false if PendingInvitation.where(mate_id: mate.id).present?
    true
  end
end
