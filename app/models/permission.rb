class Permission < Struct.new(:user)
  def allow?(controller, action)
    return true if controller == "welcome"
    return true if controller == "mountains" && action.in?(%w[index show])
    return true if controller == "registrations"
    if user
      return true if controller == "trips"
      return true if user.admin?
    end
  end
end
