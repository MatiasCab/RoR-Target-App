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
require 'rails_helper'

RSpec.describe Conversation, type: :model do
  describe 'validations' do
    subject { build :conversation }
    it { is_expected.to belong_to(:topic) }
  end
end
