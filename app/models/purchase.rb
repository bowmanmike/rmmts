class Purchase < ActiveRecord::Base
  belongs_to :mate
  has_many :payments

  mount_uploader :image, BillUploader

  def amount_paid
    paid = self.payments.sum(:amount)
  end

  def amount_owed
    owed = self.amount - self.amount_paid
  end

  def amount_for_each_mate
    each = ( self.amount / self.mate.number_of_mates ).round(2)
  end
end
