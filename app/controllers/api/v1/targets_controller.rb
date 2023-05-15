module Api
  module V1
    class TargetsController < Api::V1::ApiController
      rescue_from Pundit::NotAuthorizedError, with: :handle_pundit_error

      def create
        authorize Target
        @target = TargetService.new(current_user, resource_params).call
      end

      def index
        @targets = policy_scope(current_user.targets)
      end

      def resource_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end

      private

      def handle_pundit_error(e)
        render json: { error: { target: e } }, status: :bad_request
      end
    end
  end
end
