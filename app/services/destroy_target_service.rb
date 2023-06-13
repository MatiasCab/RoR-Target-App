class DestroyTargetService
  def initialize(current_user, id_param)
    @current_user = current_user
    @id_param = id_param
  end

  def destroy!
    Target.transaction do
      target = targets.find(@id_param)
      check_if_matched(target)
      target.destroy!
    end
  end

  private

  def targets
    @targets ||= @current_user.targets
  end

  def check_if_matched(target)
    return unless target.matched

    other_target = target.conversation.get_other_target(target)
    other_target.update!(matched: false)
    # target.conversation.destroy!
  end
end
