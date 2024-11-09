class HomeController < ApplicationController
  def index
    if user_signed_in?
      @couple = current_user.couple
      @events = @couple.events.order(created_at: :desc).limit(3) if @couple.present?
    end
  end
end
