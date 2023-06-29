module Api
  module V1
    class MessagesController < Api::V1::ApiController
      def create
        authorize Message
        @message = CreateMessageService.new(params, current_user).create!
      end
    end
  end
end
