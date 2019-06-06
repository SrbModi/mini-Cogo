class Location < ApplicationRecord
  scope :within, -> (latitude, longitude, distance_in_km = 100) {
    where(%{ST_Distance(lonlat, 'POINT(%f %f)') < %d} % [longitude, latitude, distance_in_km * 1000]) # in metres
  }

  def self.as_json_query
    return {
        only: [:id, :location_type, :location_name, :latitude, :longitude, :display_name, :postal_code,
               :google_place_id, :port_code, :currency_code, :country_code, :city, :country]
    }
  end
end