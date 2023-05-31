# == Schema Information
#
# Table name: match_users_conversations
#
#  id              :bigint           not null, primary key
#  user_id         :bigint           not null
#  target_id       :bigint           not null
#  conversation_id :bigint           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_match_users_conversations_on_conversation_id  (conversation_id)
#  index_match_users_conversations_on_target_id        (target_id)
#  index_match_users_conversations_on_user_id          (user_id)
#
require 'rails_helper'

RSpec.describe MatchUsersConversation, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
