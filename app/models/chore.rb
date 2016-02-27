class Chore < ActiveRecord::Base
  belongs_to :house
  belongs_to :mate

  validates :name, presence: true
  validates :frequency, numericality: {only_integer: true}

  def next_due_date
    # Convert today into a Date object: today
    today = Time.now.beginning_of_day.to_date
    # Convert original due date into a Date object: original_date
    original_date = self.due_date.to_date
    # Save chore's frequency: frequency
    frequency = self.frequency

    # If we have passed the chore's original due date
    if today > original_date
      # Calculate how many days have passed from the original due date
      days_past = ( today - original_date ).to_i
      # Calculate how many days have elapsed since the last due date
      days_since_last_due_date = days_past % frequency
      # Calculate the number of days until the next due date
      days_to_next_due_date = frequency - days_since_last_due_date
      # Add the number of days until the next due date to today
      next_due_date = today.advance(days: days_to_next_due_date)
    else
      next_due_date = original_date
    end

    next_due_date
  end

  def frequency_alias(frequency)

    case frequency
    when 1
      "daily"
    when 7
      "weekly"
    when 14
      "bi-weekly"
    end

  end
end
