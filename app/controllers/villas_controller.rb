class VillasController < ApplicationController
  before_action :set_villa, only: [:calculate_price]
  before_action :set_dates, only: [:index, :calculate_price]

  def index
    villas = Villa.available_for_dates(@check_in, @check_out).sorted_by(params[:sort_by], params[:sort_order])
    render json: { villas: villas }
  end

  def calculate_price
    if @villa.available_for_dates?(@check_in, @check_out)
      render json: { available: true, total_price: @villa.calculate_price(@check_in, @check_out) }
    else
      render json: { available: false, message: "Villa is not available for the selected dates." }, status: :unprocessable_entity
    end
  end

  private

  def set_villa
    @villa = Villa.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "Villa not found" }, status: :not_found
  end

  def set_dates
    return render json: { message: 'Check-in and check-out dates are required.' }, status: :bad_request unless params[:check_in] && params[:check_out]

    @check_in = DateTime.parse(params[:check_in]).change(hour: 11)
    @check_out = DateTime.parse(params[:check_out]).change(hour: 10)

    if @check_out <= @check_in
      render json: { message: 'Check-out date must be after check-in date.' }, status: :bad_request
      @check_in = @check_out = nil
    end
  rescue ArgumentError
    render json: { message: 'Invalid date format.' }, status: :bad_request
  end
end
