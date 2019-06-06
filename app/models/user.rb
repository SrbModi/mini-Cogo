class User < ApplicationRecord
  include Constants

  validates :status, inclusion: { in: UserStatusType.values } #check if the value of status is one among those in values under UserStatusType

  def self.as_json_query
    return {
        only: [:id, :name, :email, :phone_no, :status, :company_name, :user_profile_pic_url]
    }
  end
end