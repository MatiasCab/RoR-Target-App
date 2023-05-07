module Api
  module V1
    class SessionsController < DeviseTokenAuth::SessionsController
      include Api::Concerns::ActAsApiRequest
      protect_from_forgery with: :null_session
      skip_before_action :verify_authenticity_token

      private

      def resource_params
        params.require(:user).permit(:email, :password)
      end

      def render_create_success
        render :create
      end
    end
  end
end
