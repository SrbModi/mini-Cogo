class Session < ApplicationRecord

  belongs_to :user, class_name: 'User', foreign_key: 'user_id'

  def self.as_json_query
    return {
        only: [:token, :expiry_time],
        include: {
            user: {
                only: [:id, :name, :email, :phone_no, :status, :company_name, :user_profile_pic_url]
            }
        }
    }
  end
end