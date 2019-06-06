class UserService
  include Constants

  def self.get_all(query_params)
    name          = query_params[:name].present? ? query_params[:name] : nil
    email         = query_params[:email].present? ? query_params[:email].downcase : nil
    phone_no      = query_params[:phone_no].present? ? query_params[:phone_no] : nil
    status        = query_params[:status].present? ? query_params[:status].downcase : nil
    company_name  = query_params[:company_name].present? ? query_params[:company_name] : nil

    sort_by =          query_params[:sort_by].blank? ? 'name' : query_params[:sort_by].strip.downcase
    sort_type =        query_params[:sort_type].blank? ? 'ASC' : query_params[:sort_type].strip.upcase
    page =             query_params[:page].to_i > 0 ? query_params[:page].to_i : 1
    per_page_limit =   query_params[:page_limit].to_i > 0 ? query_params[:page_limit].to_i : PER_PAGE_LIMIT


    users = User.all
    users = users.where(name: name) if name.present?
    users = users.where(email: email) if email.present?
    users = users.where(phone_no: phone_no) if phone_no.present?
    users = users.where(status: status) if status.present?
    users = users.where(company_name: company_name) if company_name.present?

    users = users.order("#{sort_by} #{sort_type}")

    total_count = users.count
    total = (total_count.to_f / per_page_limit).ceil
    users = users.limit(per_page_limit).offset((page - 1) * per_page_limit)

    return {
        success: true,
        locations: users.as_json(User.as_json_query),
        page: page,
        total: total,
        totol_count: total_count,
    }
  end

  def self.create_user(params)
    data = {}
    data[:name]         = params[:name].present? ? params[:name] : nil
    data[:email]        = params[:email].present? ? params[:email] : nil
    data[:phone_no]     = params[:phone_no].present? ? params[:phone_no] : nil
    data[:company_name] = params[:company_name].present? ? params[:company_name] : nil
    data[:password]     = params[:password].present? ? params[:password] : nil
    data[:user_profile_pic_url]     = params[:user_profile_pic_url].present? ? params[:user_profile_pic_url] : nil

    data[:status] = UserStatusType::ACTIVE

    user = User.create!(data)

    return {
        success: true,
        data: user.as_json(User.as_json_query)
    }

  end

  def self.fetch_profile(user)
    return {
        success: true,
        data: user.as_json(User.as_json_query)
    }
  end

  def self.fetch_user(user)
    return {
        success: true,
        data: user.as_json(User.as_json_query)
    }
  end

  def self.update_user(user, params)
    data = {}
    data[:name]         = params[:name] if params[:name].present?
    data[:phone_no]     = params[:phone_no] if params[:phone_no].present?
    data[:company_name] = params[:company_name] if params[:company_name].present?
    data[:user_profile_pic_url]     = params[:user_profile_pic_url] if params[:user_profile_pic_url].present?

    data[:status] = params[:status] if params[:status].present?

    user.update!(data)
    return {
        success: true,
        data: user.as_json(User.as_json_query)
    }
  end

  def self.change_password(user,params)
    old_password     = params[:old_password] if params[:old_password].present?
    new_password     = params[:new_password] if params[:new_password].present?

    raise 'new_password is not present' if new_password.blank?

    if user.password != old_password
      raise 'old password is not correct!'
    end

    user.update!(password: new_password)
    return {
        success: true,
        messages: ['Your password changed successfully!!']
    }
  end
end