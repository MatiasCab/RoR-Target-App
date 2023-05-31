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
        targets = Target.mached_targets(new_target)
        targets.each do |target|
          conversation = Conversation.create!(topic_id: target.topic_id)
          MatchUsersConversation.create!(conversation_id: conversation.id, target_id: new_target.id, user_id: @current_user.id)
          MatchUsersConversation.create!(conversation_id: conversation.id, target_id: target.id, user_id: target.user_id)
        end
    end
  end