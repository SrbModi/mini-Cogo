class BookingService
  include Constants

  def self.create_booking(user, params)
    origin_port_id        = params[:origin_port_id].present? ? params[:origin_port_id] : nil
    destination_port_id   = params[:destination_port_id].present? ? params[:destination_port_id] : nil
    result_id             = params[:result_id].present? ? params[:result_id].to_i : nil

    raise 'origin_port_id is not present'       if origin_port_id.blank?
    raise 'destination_port_id is not present'  if destination_port_id.blank?
    raise 'result_id is not present'            if result_id.blank?
    raise 'result_id is not correct'            if ![1,2].include?(result_id)

    origin_port      = Location.where(location_type: LocationType::PORT, id: origin_port_id).first
    destination_port = Location.where(location_type: LocationType::PORT, id: destination_port_id).first

    raise "origin_port is not present with given id: #{origin_port_id}" if origin_port.blank?
    raise "destination_port is not present with given id: #{destination_port_id}" if destination_port.blank?

    ids_sum = (origin_port_id.sum + destination_port_id.sum)

    price = result_id == 1 ? (12*ids_sum + 1000) : (10*ids_sum + 2000)
    user_id = user.id
    currency = 'INR'
    status = BookingStatus::BOOKED

    create_data = {
        origin_port_id: origin_port.id,
        destination_port_id: destination_port.id,
        result_id: result_id,
        price: price,
        user_id: user_id,
        currency: currency,
        status: status
    }

    booking = Booking.create!(create_data)

    return {
        success: true,
        data: booking.as_json(Booking.as_json_query)
    }
  end

  def self.get_all(query_params)
    origin_port_id        = query_params[:origin_port_id].present? ? query_params[:origin_port_id] : nil
    destination_port_id   = query_params[:destination_port_id].present? ? query_params[:destination_port_id] : nil
    user_id               = query_params[:user_id].present? ? query_params[:user_id] : nil
    currency              = query_params[:currency].present? ? query_params[:currency].upcase : nil
    result_id             = query_params[:result_id].present? ? query_params[:result_id].to_i : nil
    status                = query_params[:status].present? ? query_params[:status].downcase : nil

    sort_by =          query_params[:sort_by].blank? ? 'created_at' : query_params[:sort_by].strip.downcase
    sort_type =        query_params[:sort_type].blank? ? 'DESC' : query_params[:sort_type].strip.upcase
    page =             query_params[:page].to_i > 0 ? query_params[:page].to_i : 1
    per_page_limit =   query_params[:page_limit].to_i > 0 ? query_params[:page_limit].to_i : PER_PAGE_LIMIT

    bookings = Booking.all
    bookings = bookings.where(origin_port_id: origin_port_id) if origin_port_id.present?
    bookings = bookings.where(destination_port_id: destination_port_id) if destination_port_id.present?
    bookings = bookings.where(user_id: user_id) if user_id.present?
    bookings = bookings.where(currency: currency) if currency.present?
    bookings = bookings.where(result_id: result_id) if result_id.present?
    bookings = bookings.where(status: status) if status.present?

    bookings = bookings.order("#{sort_by} #{sort_type}")

    total_count = bookings.count
    total = (total_count.to_f / per_page_limit).ceil
    bookings = bookings.limit(per_page_limit).offset((page - 1) * per_page_limit)

    return {
        success: true,
        data: bookings.as_json(Booking.as_json_query),
        page: page,
        total: total,
        total_count: total_count,
    }
  end

  def self.fetch_booking(booking)
    return {
        success: true,
        data: booking.as_json(Booking.as_json_query)
    }
  end

  def self.get_my_booking(user, params)
    response = self.get_all(params.merge(user_id: user.id))
    return response
  end

end