# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  title      :string
#  radius     :float
#  lat        :float
#  lng        :float
#  user_id    :bigint
#  topic_id   :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
FactoryBot.define do
  factory :target do
    title       { Faker::Name.name }
    radius      { Faker::Number.between(from: 1.0, to: 600.0).round(2)  }
    lat         { Faker::Address.latitude } 
    lng         { Faker::Address.longitude } 
    association :user, factory: :user
    association :topic, factory: :topic

    before(:create) do |instance|
      instance.user = create(:user)
      instance.topic = create(:topic)
    end
  end
end
