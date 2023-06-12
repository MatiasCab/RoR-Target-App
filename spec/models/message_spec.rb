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
require 'rails_helper'

RSpec.describe Message, type: :model do
  subject { build :message }
  it { is_expected.to validate_presence_of(:content) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:conversation) }
end
