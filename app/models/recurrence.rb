module Recurrence

  def frequency
    case self.frequency_unit
    when "days"
      "day"
    when "weeks"
      "week"
    when "months"
      "month"
    when "years"
      "year"
    end
  end

  def correct_weekday
    if self.frequency_weekday.present?
      unless self.due_date.strftime("%A") == self.frequency_weekday
        weekday_sym = self.frequency_weekday.downcase.to_sym
        new_due_date = due_date.end_of_week(weekday_sym).advance(days: 1)
      end
    else
      new_due_date = self.due_date
    end
    new_due_date
  end

end
