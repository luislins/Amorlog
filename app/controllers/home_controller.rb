class HomeController < ApplicationController

  def index
    @events = @couple&.events&.order(created_at: :desc)&.limit(3)
    @savings_table = @couple&.savings_table
  end

end
