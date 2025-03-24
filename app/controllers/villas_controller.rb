class VillasController < ApplicationController
  before_action :set_villa, only: [ :calculate_price ]
  before_action :validate_dates, only: [ :index, :calculate_price ]

  def index
    sort_by_price = params[:sort_by_price]&.downcase == "desc" ? "DESC" : "ASC"
    villas = Villa.available_for_dates(@check_in, @check_out, sort_by_price)
    render json: { villas: villas }
  end

  def calculate_price
    total_nights = (@check_out.to_date - @check_in.to_date).to_i

    available_calendars = @villa.villa_calendars
      .where(date: @check_in...@check_out)
      .pluck(:price, :is_available)

    if available_calendars.size != total_nights || available_calendars.any? { |available| available[1] == false }
      return render json: { available: false, message: "Villa is not available for the full requested period" }, status: :unprocessable_entity
    end

    total_price = available_calendars.sum { |price| price[0] } * 1.18

    render json: { available: true, total_price: total_price.round }
  end


  private

  def set_villa
    @villa = Villa.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Villa not found" }, status: :not_found
  end

  def validate_dates
    @check_in = params[:check_in]
    @check_out = params[:check_out]

    if @check_in.blank? || @check_out.blank?
      render json: { error: "Check-in and check-out dates are required" }, status: :unprocessable_entity
    end
  end
end
