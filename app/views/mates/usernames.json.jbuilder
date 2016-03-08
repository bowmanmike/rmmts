# json.mates @mates do |mate|
#   json.username mate.username
# end

json.array! @mates.pluck(:username)
