class CreateTargetService
  def initialize(current_user, params)
    @current_user = current_user
    @params = params
  end

  def create!
    Target.transaction do
      target = targets.create!(@params)
      check_matchs(target)
      target
    end
  end

  private

  def targets
    @targets ||= @current_user.targets
  end

  def check_matchs(new_target)
    matched_target = find_target_to_match(new_target)
    return if matched_target.nil?

    matched_target.update!(matched: true)
    new_target.update!(matched: true)

    create_conversation(matched_target, new_target)
  end

  def create_conversation(matched_target1, matched_target2)
    conversation = Conversation.create!(topic_id: matched_target1.topic_id)
    MatchUsersConversation.create!(conversation_id: conversation.id, target_id: matched_target2.id,
                                   user_id: matched_target2.user.id)
    MatchUsersConversation.create!(conversation_id: conversation.id,
                                   target_id: matched_target1.id, user_id: matched_target1.user.id)
  end

  def find_target_to_match(new_target)
    matched_targets = Target.mached_targets(new_target)
    matched_targets.each do |target|
      conversation = Conversation.conversation_between_users(new_target.user, target.user).first
      return target if conversation.nil?
    end
    nil
  end
end
