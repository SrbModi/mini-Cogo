class Api::V1::Registered::SearchsController < RegisteredController
  before_action :set_service

  def get_search_results
    response = @service.get_search_results(search_params)
    render json: response
  end

  private

  def set_service
    @service ||= ::SearchService
  end

  def search_params
    params.permit(:origin_port_id, :destination_port_id)
  end
end