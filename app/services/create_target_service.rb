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
        matched_targets = Target.mached_targets(new_target)
        matched_target = nil
        matched_targets.each do |target|
          conversation = Conversation.conversation_between_users(new_target.user, target.user).first
          if conversation.nil?
            matched_target = target
            break
          end
        end

        return if matched_target.nil?

        conversation = Conversation.conversation_between_users(new_target.user, matched_target.user).first

        matched_target.update!(matched: true)
        new_target.update!(matched: true)
        
        conversation = Conversation.create!(topic_id: matched_target.topic_id)
        MatchUsersConversation.create!(conversation_id: conversation.id, target_id: new_target.id, user_id: new_target.user.id)
        MatchUsersConversation.create!(conversation_id: conversation.id, target_id: matched_target.id, user_id: matched_target.user.id)
    end
  end