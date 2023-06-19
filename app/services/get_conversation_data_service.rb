class GetConversationDataService
  def initialize(target)
    @target = target
    @user = target.user
    @conversation = target.conversation
  end

  def other_user
    first_conversation_user = conversation_users.first
    return first_conversation_user if first_conversation_user.id != @user.id

    conversation_users.second
  end

  def other_target
    first_conversation_target = conversation_targets.first
    return first_conversation_target if first_conversation_target.id != @target.id

    conversation_targets.second
  end

  private

  def conversation_users
    @conversation_users ||= @conversation.users
  end

  def conversation_targets
    @conversation_targets ||= @conversation.targets
  end
end
