# == Schema Information
#
# Table name: plans
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  target_limit :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
FactoryBot.define do
  factory :plan do
    sequence(:id) { |n| n + 2 }

    name          { Faker::Name.name }
    target_limit  { Faker::Number.between(from: 3, to: 100) }
  end
end
