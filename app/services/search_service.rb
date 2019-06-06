class SearchService

  def self.get_search_results(params)
    # byebug
    origin_port_id = params[:origin_port_id].present? ? params[:origin_port_id] : nil
    destination_port_id = params[:destination_port_id].present? ? params[:destination_port_id] : nil


    raise 'origin_port or destination_port is not present' if (origin_port_id.blank? || destination_port_id.blank?)
    raise 'origin_port and destination_port cannot be same' if (origin_port_id == destination_port_id)

    origin_port       = Location.where(location_type: 'port', id: origin_port_id).first
    destination_port  = Location.where(location_type: 'port', id: destination_port_id).first

    raise "origin_port is not present with given id: #{origin_port_id}" if origin_port.blank?
    raise "destination_port is not present with given id: #{destination_port_id}" if destination_port.blank?

    results = []
    origin_json       = origin_port.as_json(Location.as_json_query)
    destination_json  = destination_port.as_json(Location.as_json_query)

    ids_sum = origin_port_id.sum + destination_port_id.sum



    result_hash = {
        origin_port: origin_json,
        destination_port: destination_json,
        rate: (10*ids_sum + 2000),
        currency: 'INR',
        result_id: 1
    }

    results << result_hash

    result_hash = {
        origin_port: origin_json,
        destination_port: destination_json,
        rate: (12*ids_sum + 1000),
        currency: 'INR',
        result_id: 2
    }

    results << result_hash
    return {
        success: true,
        data: results
    }
  end
end