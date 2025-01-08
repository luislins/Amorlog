class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  skip_before_action :set_couple, only: :index

  def index
    return unless user_signed_in?

    @events = @couple&.events&.order(created_at: :desc)&.limit(3)
  end
end
