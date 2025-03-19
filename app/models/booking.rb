class Booking < ApplicationRecord
  belongs_to :villa

  before_create :set_default_times

  validates :check_in, :check_out, :price, presence: true
  validate :valid_dates

  private

  def set_default_times
    self.check_in = check_in.beginning_of_day + 11.hours if check_in.present?
    self.check_out = check_out.beginning_of_day + 10.hours if check_out.present?
  end

  def valid_dates
    errors.add(:check_out, "must be after check-in") if check_out <= check_in
  end
end
