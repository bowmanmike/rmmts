class Purchase < ActiveRecord::Base
  belongs_to :mate
  has_many :payments, dependent: :destroy

  mount_uploader :image, BillUploader

  def amount_paid
    paid = self.payments.sum(:amount)
  end

  def amount_owed
    owed = self.amount - self.amount_paid - self.amount_for_each
  end

  def amount_for_each
    each = ( self.amount / self.mate.house.mates.size ).round(2)
  end

  # def grouped_payments
  #   grouped_payments = self.payments.group(:mate_id).sum(:amount)
  # end

  def payments_paid_by(housemate)
    housemate_payments = self.payments.where(mate_id: housemate.id)
  end

  def amount_paid_by(housemate)
    housemate_paid = self.payments_paid_by(housemate).sum(:amount)
  end

  def amount_owed_by(housemate)
    housemate_owes = self.amount_for_each - self.amount_paid_by(housemate)
  end

  def fully_paid?
    self.amount_paid >= self.amount
  end

  def paid_by?(housemate)
    self.amount_paid_by(housemate) >= self.amount_for_each
  end
end
