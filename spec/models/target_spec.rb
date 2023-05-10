require 'rails_helper'

RSpec.describe Target, type: :model do
  subject { build :target }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:radius) }
    it { is_expected.to validate_presence_of(:lat) }
    it { is_expected.to validate_presence_of(:lng) }
    it { is_expected.to validate_numericality_of(:radius).is_greater_than(0)}
    it { is_expected.to validate_numericality_of(:lat)}
    it { is_expected.to validate_numericality_of(:lng)}

    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:topic) }
  end
end
