class Api::V1::Registered::UsersController < RegisteredController
  before_action :set_service
  before_action :set_user, only: [:fetch_user, :update_user]

  def index
    response = @service.get_all(query_params)
    render json: response
  end

  def create_user
    response = @service.create_user(create_params)
    render json: response
  end

  def fetch_profile
    response = @service.fetch_profile(@current_user)
    render json: response
  end

  def fetch_user
    response = @service.fetch_user(@user)
    render json: response
  end

  def update_user
    response = @service.update_user(@user, update_params)
    render json: response
  end

  def change_password
    response = @service.change_password(@current_user, password_params)
    render json: response
  end
  private

  def set_service
    @service ||= ::UserService
  end

  def set_user
    @user = User.where(id: params[:id]).first
    if @user.blank?
      render json: {success: false, messages: ["user not present with the given id #{params[:id]}"]}
    end
  end

  def query_params
    params.permit(:name, :email, :phone_no, :status, :company_name, :sort_by, :sort_type, :page, :page_limit)
  end

  def create_params
    params.permit(:name, :email, :phone_no, :company_name, :password, :status)
  end

  def password_params
    params.permit(:old_password, :new_password)
  end

  def update_params
    params.permit(:name, :phone_no, :company_name, :user_profile_pic_url)
  end
end