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
    name          { Faker::Name.name }
    target_limit  { 3 }
  end
end
