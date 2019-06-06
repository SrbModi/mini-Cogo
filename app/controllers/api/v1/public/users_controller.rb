class Api::V1::Public::UsersController < ApiController
  before_action :set_service

  def create_user
    response = @service.create_user(create_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::UserService
  end

  def create_params
    params.permit(:name, :email, :phone_no, :company_name, :password, :status)
  end
end