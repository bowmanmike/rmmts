class Purchase < ActiveRecord::Base
  belongs_to :mate
  has_many :payments

  mount_uploader :image, BillUploader

  def amount_paid
    paid = self.payments.sum(:amount) + self.amount_for_each_mate
  end

  def amount_owed
    owed = self.amount - self.amount_paid
  end

  def amount_for_each_mate
    each = ( self.amount / self.mate.house.mates.size ).round(2)
  end

  def payments_paid_by_mate(housemate)
    housemate_payments = self.payments.where(id: housemate.id)
  end

  def amount_paid_by_mate(housemate)
    housemate_paid = self.payments_paid_by_mate(housemate).sum(:amount)
  end

  def amount_owed_by_mate(housemate)
    housemate_owes = self.amount_for_each_mate - self.amount_paid_by_mate(housemate)
  end

  def fully_paid?
    self.amount_paid >= self.amount
  end
end
