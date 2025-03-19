require 'faker'

50.times do
  Villa.create!(
    name: Faker::Address.community,
    price_per_night: rand(30_000..50_000)
  )
end

100.times do
  villa = Villa.order("RANDOM()").first
  check_in = Faker::Date.between(from: '2025-01-01', to: '2025-12-31')
  nights = rand(1..7)
  check_out = check_in + nights.days
  price_per_night = villa.price_per_night

  total_price = (nights * price_per_night) * 1.18

  Booking.create!(
    villa: villa,
    check_in: check_in.change(hour: 11),
    check_out: check_out.change(hour: 10),
    price: total_price.round
  )
end
