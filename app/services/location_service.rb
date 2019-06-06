class LocationService
include Constants

def self.fetch_locations(query_params)
  query         = query_params[:q].present? ? query_params[:q].downcase : nil
  country_code  = query_params[:country_code].present? ? query_params[:country_code].upcase : nil
  location_type = query_params[:location_type].present? ? query_params[:location_type].downcase : nil

  sort_by =          query_params[:sort_by].blank? ? 'location_name' : query_params[:sort_by].strip.downcase
  sort_type =        query_params[:sort_type].blank? ? 'ASC' : query_params[:sort_type].strip.upcase
  page =             query_params[:page].to_i > 0 ? query_params[:page].to_i : 1
  per_page_limit =   query_params[:page_limit].to_i > 0 ? query_params[:page_limit].to_i : PER_PAGE_LIMIT


  locations = Location.all
  locations = locations.where('location_name ILIKE ?', "%#{query}%") if query.present?
  locations = locations.where(country_code: country_code) if country_code.present?
  locations = locations.where(location_type: location_type) if location_type.present?

  locations = locations.order("#{sort_by} #{sort_type}")

  total_count = locations.count
  total = (total_count.to_f / per_page_limit).ceil
  locations = locations.limit(per_page_limit).offset((page - 1) * per_page_limit)

  return {
      success: true,
      data: locations.as_json(Location.as_json_query),
      page: page,
      total: total,
      totol_count: total_count,
  }
end

def self.fetch_nearby_locations(params)
  latitude      = params[:latitude].present? ? params[:latitude].to_f : nil
  longitude     = params[:longitude].present? ? params[:longitude].to_f : nil
  distance      = params[:distance].present? ? params[:distance].to_i : 100

  location_type = params[:location_type].present? ? params[:location_type].downcase : nil

  raise 'latitude or longitude is not present' if (latitude.blank? || longitude.blank?)

  # byebug
  nearby_locations = Location.within(latitude, longitude, distance)
  nearby_locations = nearby_locations.where(location_type: location_type) if location_type.present?

  return {
      success: true,
      data: nearby_locations.as_json(Location.as_json_query),
      count: nearby_locations.count
  }
end
end