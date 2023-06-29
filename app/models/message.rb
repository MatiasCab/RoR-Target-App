# == Schema Information
#
# Table name: messages
#
#  id              :bigint           not null, primary key
#  content         :string           not null
#  user_id         :bigint           not null
#  conversation_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_messages_on_conversation_id  (conversation_id)
#  index_messages_on_user_id          (user_id)
#
class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  validates :content, presence: true
end
