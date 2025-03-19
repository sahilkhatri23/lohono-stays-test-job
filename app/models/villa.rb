class Villa < ApplicationRecord
  has_many :bookings

  scope :available_for_dates, ->(check_in, check_out) {
    where.not(id: Booking.where(
      "(check_in < ? AND check_out > ?) OR (check_out = ? AND check_out::time > '10:00:00')",
      check_out, check_in, check_in
    ).select(:villa_id))
  }

  scope :sorted_by, ->(sort_by, sort_order) {
    return all unless sort_by == 'price'
    order(price_per_night: sort_order&.downcase == 'desc' ? :desc : :asc)
  }

  def available_for_dates?(check_in, check_out)
    self.class.available_for_dates(check_in, check_out).exists?(id: self.id)
  end

  def calculate_price(check_in, check_out)
    total_nights = (check_out.to_date - check_in.to_date).to_i
    (total_nights * price_per_night) * 1.18
  end
end
