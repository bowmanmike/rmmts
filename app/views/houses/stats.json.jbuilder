# Data to render points pie chart

json.points do
  json.array! @house.mates do |mate|
    json.value mate.points.sum(:amount).to_i
    json.label mate.first_name
  end
end

## Create data for expenses dataset
expenses_by_month = {}
# Group household expenses by month, and add the expenses totals to a hash called expenses_by_month
@house.expenses.select("date_trunc('month', due_date) as month, sum(amount) as total_amount").group('month').each do |expense|
  expenses_by_month[expense.month.strftime("%B")] = expense.total_amount
end
# For each month in the year, add the household expense total if it exists for that month
# If it does not, add in 0 for that month
expense_data = []
Date::MONTHNAMES.each do |monthname|
  if expenses_by_month[monthname] != nil
    expense_data << expenses_by_month[monthname]
  else
    expense_data << 0
  end
end
# Remove the nil month value from the front of the data array
expense_data.shift

## Create data for purchases dataset
purchases_by_month = {}
# Group household expenses by month, and add the expenses totals to a hash called expenses_by_month
@house.purchases.select("date_trunc('month', due_date) as month, sum(amount) as total_amount").group('month').each do |purchase|
  purchases_by_month[purchase.month.strftime("%B")] = purchase.total_amount
end
# For each month in the year, add the household expense total if it exists for that month
# If it does not, add in 0 for that month
purchase_data = []
Date::MONTHNAMES.each do |monthname|
  if purchases_by_month[monthname] != nil
    purchase_data << purchases_by_month[monthname]
  else
    purchase_data << 0
  end
end
# Remove the nil month value from the front of the data array
purchase_data.shift

expense_dataset = {}
expense_dataset[:label] = "Expenses"
expense_dataset[:data] = expense_data
purchase_dataset = {}
purchase_dataset[:label] = "Purchases"
purchase_dataset[:data] = purchase_data
spending = []
spending << expense_dataset
spending << purchase_dataset
spending

json.spending spending
