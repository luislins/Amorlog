class Users::RegistrationsController < Devise::RegistrationsController
    def create
      super do |resource|
        if resource.persisted?
          Couple.create!(
            user: resource,
            partner_1: params[:user][:partner_1],
            partner_2: params[:user][:partner_2]
          )
        end
      end
    end
end
