class Api::V1::Registered::BookingsController < RegisteredController
  before_action :set_service
  before_action :set_booking, only: [:fetch_booking]

  def get_all
    response = @service.get_all(query_params)
    render json: response
  end

  def get_my_booking
    response = @service.get_my_booking(@current_user, query_params)
    render json: response
  end

  def create_booking
    response = @service.create_booking(@current_user, create_params)
    render json: response
  end

  def fetch_booking
    response = @service.fetch_booking(@booking)
    render json: response
  end

  private

  def set_service
    @service ||= ::BookingService
  end

  def set_booking
    @booking = Booking.where(id: params[:id]).first
    if @booking.blank?
      render json: {success: false, messages: ["booking not present with the given id #{params[:id]}"]}
    end
  end

  def create_params
    params.permit(:origin_port_id, :destination_port_id, :result_id)
  end

  def query_params
    params.permit(:origin_port_id, :destination_port_id, :user_id, :result_id, :page, :sort_type, :sort_by,
                  :page_limit)
  end
end