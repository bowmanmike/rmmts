# Data to render points pie chart

json.points do
  json.array! @house.mates do |mate|
    json.value mate.points.sum(:amount).to_i
    json.label mate.first_name
  end
end

json.spending do
  json.array! @house.expenses.select("date_trunc('month', due_date) as month, sum(amount) as total_amount").group('month').each do |month|
    json.value month.total_amount
    json.label month.month.strftime("%B")
  end
end
