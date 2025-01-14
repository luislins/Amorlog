class HomeController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  
  def index
    @events = @couple&.events&.order(created_at: :desc)&.limit(3)
    @savings_table = @couple&.savings_table
  end

end
