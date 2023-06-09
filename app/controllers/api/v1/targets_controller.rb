module Api
  module V1
    class TargetsController < Api::V1::ApiController
      def index
        @targets = policy_scope(current_user.targets)
      end

      def create
        authorize Target
        @target = CreateTargetService.new(current_user, resource_params).create!
        if @target.matched 
          @user_match = @target.match_users_conversation.conversation.get_other_user(@target.user)
        end
      end

      def destroy
        authorize Target
        @target = DestroyTargetService.new(current_user, params[:id]).destroy!
      end

      def resource_params
        params.require(:target).permit(:title, :lat, :lng, :radius, :topic_id)
      end
    end
  end
end
