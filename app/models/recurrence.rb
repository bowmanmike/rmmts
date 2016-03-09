module Recurrence

  # def recurrence_alias(frequency_integer, frequency_unit)
  #   case frequency_unit
  #   when "days"
  #     case frequency_integer
  #     when 1
  #       "daily"
  #     when 2
  #       "every other day"
  #     else
  #       "every #{frequency_integer} days"
  #     end
  #   when "weeks"
  #     case frequency_integer
  #     when 1
  #       "every #{week_day}"
  #     else
  #       "every #{frequency_integer} weeks"
  #     end
  #   when "months"
  #     case frequency_integer
  #     when 1
  #       "on the #{ordinalize(month_day)} of every month"
  #     when 2
  #       "every other month, on the #{ordinalize(month_day)}"
  #     else
  #       "every #{frequency_integer} months, on the #{ordinalize(month_day)}"
  #     end
  #   when "years"
  #     case frequency_integer
  #     when 1
  #       "every year"
  #     else
  #       "every #{frequency_integer} years"
  #     end
  #   end
  # end

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
    if self.frequency_weekday != nil
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
