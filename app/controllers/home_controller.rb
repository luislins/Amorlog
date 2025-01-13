class HomeController < ApplicationController
  skip_before_action :authenticate_user!, only: :index
  before_action :conditionally_skip_set_couple


  def index
    return unless user_signed_in?

    @events = @couple&.events&.order(created_at: :desc)&.limit(3)
    @savings_table = @couple.savings_table
  end

  private

  def conditionally_skip_set_couple
    skip_before_action :set_couple, only: :index unless user_signed_in?
  end

end
