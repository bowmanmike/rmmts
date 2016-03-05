module Recurrence

  def recurrence_alias(frequency_integer, frequency_unit, week_day, month_day)

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

end
