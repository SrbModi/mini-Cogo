
class Api::V1::Public::SessionsController < ApiController
  before_action :set_service

  def create_session
    response = @service.create_session(create_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::SessionService
  end

  def create_params
    params.permit(:email, :password)
  end
end