class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  validates :name, presence: true
  validates :frequency_integer, numericality: {only_integer: true}

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

  # def frequency_alias
  #   case self.frequency_unit
  #   when "days"
  #     self.frequency_integer == 1 ? "daily" : self.frequency_unit
  #   when "weeks"
  #     self.frequency_integer == 1 ? "weekly" : self.frequency_unit
  #   when "months"
  #     self.frequency_integer == 1? "monthly" : self.frequency_unit
  #   else
  #     self.frequency_unit
  #   end
  # end
end
