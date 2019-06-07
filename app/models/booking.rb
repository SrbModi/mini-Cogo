class Booking < ApplicationRecord
  include Constants

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :origin_port, class_name: 'Location', foreign_key: 'origin_port_id'
  belongs_to :destination_port, class_name: 'Location', foreign_key: 'destination_port_id'

  validates :status, inclusion: { in: BookingStatus.values }

  def self.as_json_query
    return {
        only: [:id, :price, :currency, :created_at, :updated_at, :result_id, :status],
        include: {
            user: User.as_json_query,
            origin_port: Location.as_json_query,
            destination_port: Location.as_json_query,
        }
    }
  end
end