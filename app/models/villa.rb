class Villa < ApplicationRecord
  has_many :villa_calendars, dependent: :destroy

  after_create :generate_calendar

  scope :available_for_dates, ->(check_in, check_out, order) {
    joins(:villa_calendars)
    .where(
      "villa_calendars.date >= ? AND villa_calendars.date < ? AND villa_calendars.is_available = ?",
      check_in, check_out, true
    )
    .group("villas.id")
    .having("COUNT(villa_calendars.id) = ?", (check_out.to_date - check_in.to_date).to_i)
    .select("villas.*, AVG(villa_calendars.price) AS average_price_per_night")
    .order("average_price_per_night #{order}")
  }

  private

  def generate_calendar
    start_date = Date.today
    end_date = start_date + 12.months

    (start_date..end_date).each do |date|
      villa_calendars.create!(
        date: date,
        price: rand(30_000..50_000)
      )
    end
  end
end
