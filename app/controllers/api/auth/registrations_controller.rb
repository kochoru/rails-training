module Api
  module Auth
    class RegistrationsController < DeviseTokenAuth::RegistrationsController

      private
      def sign_up_params
        params.permit(:name, :email, :department, :password, :password_confirmation)
      end

      def account_update_params
        params.permit(:mame, :email, :department)
      end
    
    end
  end
end
