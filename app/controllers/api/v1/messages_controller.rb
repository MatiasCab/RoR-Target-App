module Api
    module V1
        class MessagesController <  Api::V1::ApiController
            def create 
                authorize Message
                @message = conversation_messages.create!(resource_params)
            end

            private 

            def conversation_messages
                current_user.conversations.find(params[:conversation_id]).messages
            end

            def resource_params
                params.require(:message).permit(:content).merge(user_id: current_user.id)
            end
        end        
    end
  end
  