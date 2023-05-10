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
