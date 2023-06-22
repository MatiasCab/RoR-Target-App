module Api
    module V1
        class MessagesController <  Api::V1::ApiController
            def index
                @messages = policy_scope(conversation_messages.paginate(page: params[:page], per_page: Message::PAGINATION_LIMIT))
            end

            def create 
                authorize Message
                @message = conversation_messages.create!(resource_params)
            end

            private 

            def conversation_messages
                current_user.conversations.find(params[:conversation_id]).messages
            end

            #FIXME user_id merge?
            def resource_params
                params.require(:message).permit(:content).merge(user_id: current_user.id)
            end
        end        
    end
  end
  