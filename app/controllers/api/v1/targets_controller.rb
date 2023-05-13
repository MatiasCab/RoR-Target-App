module Api
  module V1
    class TargetsController < Api::V1::ApiController
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
    end
  end
end
