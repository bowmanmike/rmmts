class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  validates :name, presence: true
  validates :frequency_integer, numericality: {only_integer: true}
  validates :frequency_unit, presence: true
  validates :due_date, presence: true

  def check_status
    return if !self.recurring?
    if self.complete?
      self.complete = false
      update_due_date
    else
      update_due_date
    end
  end

  def update_due_date
    options = { self.frequency_unit.to_sym => self.frequency_integer }
    self.due_date = self.due_date.advance(options)
    self.save
  end

end
