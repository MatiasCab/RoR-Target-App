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

  scope :conversation_between_users, lambda { |base_user, matched_user|
                                       joins(:users)
                                         .where(users: { id: [base_user.id, matched_user.id] })
                                     }

  def get_other_user(user)
    first_conversation_user = conversation_users.first
    return first_conversation_user if first_conversation_user.id != user.id

    conversation_users.second
  end

  def get_other_target(target)
    first_conversation_target = conversation_targets.first
    return first_conversation_target if first_conversation_target.id != target.id

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
