module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def index
        @messages = policy_scope(policy_scope(conversation_messages.page(
          params[:page]
        ).per(Message::PAGINATION_LIMIT)))
      end

      def create
        authorize Message
        @message = CreateMessageService.new(params, current_user).create!
      end

      private

      def conversation_messages
        current_user.conversations.find(params[:conversation_id]).messages
      end
    end
  end
end
