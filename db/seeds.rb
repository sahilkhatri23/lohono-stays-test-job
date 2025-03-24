require 'faker'

50.times do
  Villa.create!(name: Faker::Address.community)
end

calendar_count = VillaCalendar.count
calendars_to_update = (calendar_count * 0.3).to_i

VillaCalendar.order("RANDOM()").limit(calendars_to_update).update_all(is_available: false)
