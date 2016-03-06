module Recurrence

  def recurrence_alias(frequency_integer, frequency_unit, day_of_week, day_of_month)
    case frequency_unit
    when "day"
      case frequency_integer
      when 1
        "daily"
      when 2
        "every other day"
      else
        "every #{frequency_integer} days"
      end
    when "week"
      case frequency_integer
      when 1
        "every #{week_day}"
      else
        "every #{frequency_integer} weeks, on #{week_day}"
      end
    when "month"
      case frequency_integer
      when 1
        "on the #{ordinalize(month_day)} of every month"
      when 2
        "every other month, on the #{ordinalize(month_day)}"
      else
        "every #{frequency_integer} months, on the #{ordinalize(month_day)}"
      end
    when "year"
      case frequency_integer
      when 1
        "every year"
      else
        "every #{frequency_integer} years"
      end
    end
  end

  def correct_weekday
    if self.weekday != nil
      unless self.due_date.strftime("%A") == self.frequency_weekday
        weekday_sym = self.frequency_weekday.downcase.to_sym
        new_due_date = due_date.end_of_week(weekday_sym).advance(days: 1)
      end
    end
    new_due_date
  end

end
