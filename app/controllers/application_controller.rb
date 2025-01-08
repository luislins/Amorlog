class ApplicationController < ActionController::Base
 before_action :authenticate_user!
 before_action :set_couple, if: :current_user

 private

  def set_couple
    @couple = current_user.couple

    if @couple.nil?
      redirect_to root_path, alert: 'Você ainda não possui um casal associado.'
    end
  end
end
