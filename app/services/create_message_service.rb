class CreateMessageService
  attr_reader :current_user, :params

  def initialize(params, current_user)
    @current_user = current_user
    @params = params
  end

  def create!
    message_info = {
      content: resource_params[:content],
      user_id: current_user.id
    }
    conversation_messages.create!(message_info)
  end

  private

  def conversation_messages
    @conversation_messages ||= current_user.conversations.find(params[:conversation_id]).messages
  end

  def resource_params
    @resource_params ||= params.require(:message).permit(:content)
  end
end
