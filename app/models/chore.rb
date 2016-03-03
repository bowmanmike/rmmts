class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate
  belongs_to :creator, class_name: Mate

  validates :name, presence: true
  validates :frequency_integer, numericality: {only_integer: true}

  after_save :test_job_job

  def test_job_job
    # @chore = Chore.order(updated_at: :desc).first
    TestJobJob.perform_later
  end

  def check_status
    return if !self.recurring?
    if self.complete?
      puts "Chore complete"
      self.complete = false
      update_due_date
    else
      puts "Chore incomplete"
      update_due_date
    end
  end

  def update_due_date
    options = { self.frequency_unit.to_sym => self.frequency_integer }
    self.due_date = self.due_date.advance(options)
    self.save
  end

  # def next_due_date
  #   # Convert today into a Date object: today
  #   today = Time.now.beginning_of_day.to_date
  #   # Convert original due date into a Date object: original_date
  #   original_date = self.due_date.to_date
  #   # Save chore's frequency: frequency
  #   frequency = self.frequency
  #
  #   # If we have passed the chore's original due date
  #   if today > original_date
  #     # Calculate how many days have passed from the original due date
  #     days_past = ( today - original_date ).to_i
  #     # Calculate how many days have elapsed since the last due date
  #     days_since_last_due_date = days_past % frequency
  #     # Calculate the number of days until the next due date
  #     days_to_next_due_date = frequency - days_since_last_due_date
  #     # Add the number of days until the next due date to today
  #     next_due_date = today.advance(days: days_to_next_due_date)
  #   else
  #     next_due_date = original_date
  #   end
  #
  #   next_due_date
  # end

  def frequency_alias

    case self.frequency_integer
    when 1
      "daily"
    when 7
      "weekly"
    when 14
      "bi-weekly"
    else
      "every #{self.frequency} days(s)"
    end

  end
end
