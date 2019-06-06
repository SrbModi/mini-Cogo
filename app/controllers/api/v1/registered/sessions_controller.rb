class Api::V1::Registered::SessionsController < RegisteredController
  before_action :set_service

  def delete_session
    response = @service.delete_session(delete_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::SessionService
  end

  def delete_params
    params.permit(:cookie)
  end
end