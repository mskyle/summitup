class WelcomeController < ApplicationController
  def index
    if user_signed_in
      @user_trips = current_user.trips 
    end
  end 
end
