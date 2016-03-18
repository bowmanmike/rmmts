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

# var data = {
#     labels: ["January", "February", "March", "April", "May", "June", "July"],
#     datasets: [
#         {
#             label: "My First dataset",
#             fillColor: "rgba(220,220,220,0.5)",
#             strokeColor: "rgba(220,220,220,0.8)",
#             highlightFill: "rgba(220,220,220,0.75)",
#             highlightStroke: "rgba(220,220,220,1)",
#             data: [65, 59, 80, 81, 56, 55, 40]
#         },
#         {
#             label: "My Second dataset",
#             fillColor: "rgba(151,187,205,0.5)",
#             strokeColor: "rgba(151,187,205,0.8)",
#             highlightFill: "rgba(151,187,205,0.75)",
#             highlightStroke: "rgba(151,187,205,1)",
#             data: [28, 48, 40, 19, 86, 27, 90]
#         }
#     ]
# };
