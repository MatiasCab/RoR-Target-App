# == Schema Information
#
# Table name: conversations
#
#  id         :bigint           not null, primary key
#  topic_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_conversations_on_topic_id  (topic_id)
#
class Conversation < ApplicationRecord
  belongs_to :topic
  has_many :match_users_conversations, dependent: :destroy
  has_many :users, through: :match_users_conversations
  has_many :targets, through: :match_users_conversations

  scope :conversation_between_users, lambda { |user1, user2|
                                       joins(:users).where(users: { id: [user1.id, user2.id] })
                                     }

  def get_other_user(user)
    return conversation_users.first if conversation_users.first.id != user.id

    conversation_users.second
  end

  def get_other_target(target)
    return conversation_targets.first if conversation_targets.first.id != target.id

    conversation_targets.second
  end

  private

  def conversation_users
    @conversation_users ||= users
  end

  def conversation_targets
    @conversation_targets ||= targets
  end
end
