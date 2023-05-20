module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = policy_scope(current_user.targets)
      end

      def create
        authorize Target
        @target = TargetService.new(current_user, create_resource_params).create!
      end

      def destroy
        authorize Target
        @target = TargetService.new(current_user, delete_resource_params).destroy!
      end

      def create_resource_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end

      def delete_resource_params
        params.require(:id)
      end
    end
  end
end
