module Api
  module V1
    class RegistrationsController < DeviseTokenAuth::RegistrationsController
      protect_from_forgery with: :exception, unless: :json_request?
      include Api::Concerns::ActAsApiRequest

      private

      def sign_up_params
        CreateUserService.new(params).sign_up_info
      end

      def render_create_success
        render :create
      end
    end
  end
end
