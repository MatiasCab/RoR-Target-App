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
FactoryBot.define do
  factory :conversation do
    association :topic, factory: :topic
  end
end
