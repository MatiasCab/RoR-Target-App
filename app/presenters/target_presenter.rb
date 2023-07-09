class TargetPresenter < SimpleDelegator
  def user_name
    user.first_name
  end

  def topic_title
    topic.name
  end
end
