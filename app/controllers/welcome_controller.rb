class WelcomeController < ApplicationController
  def index
    @user_trips = current_user.trips 
  end 
end
