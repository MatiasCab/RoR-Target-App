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
require 'rails_helper'

RSpec.describe Plan, type: :model do
  subject { build :plan }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:target_limit) }
  it { is_expected.to validate_numericality_of(:target_limit).is_greater_than_or_equal_to(-1) }
end
