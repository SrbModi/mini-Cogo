class RegisteredController < ApplicationController
  before_action :authenticate_user

  def authenticate_user
    token = params[:cookie]
    @current_user = SessionService.check_session(token)
    if @current_user.blank?
      render json: { success: false, is_authenticated: false }, status: 401
    end
  end

end