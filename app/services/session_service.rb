class SessionService
  def self.create_session(params)
    email = params[:email].present? ? params[:email].downcase : nil
    password = params[:password]
    raise 'Email is not present' if email.blank?
    raise 'Password is not present' if password.blank?

    user = User.where(email: email).first
    raise "No user exist with email #{email}" if user.blank?

    if user.password != password
      raise 'Password is not correct.'
    end

    expiry_time = Time.zone.now + 2.hours
    token = SecureRandom.alphanumeric(20)

    session = Session.create!(user_id: user.id, expiry_time: expiry_time, token: token)
    return {
        success: true,
        data: session.as_json(Session.as_json_query)
    }
  end

  def self.delete_session(params)
    token = params[:cookie]
    session = Session.where(token: token).where('expiry_time >= ?', Time.zone.now).first

    raise 'sessions does not exist' if session.blank?
    session.update!(expiry_time: Time.zone.now)

    return {
        success: true
    }
  end

  def self.check_session(token)
    return nil if token.blank?
    session = Session.where(token: token).where('expiry_time >= ?', Time.zone.now).first

    return nil if session.blank?
    current_user = User.find(session.user_id)

    return current_user
  end
end