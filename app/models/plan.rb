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
class Plan < ApplicationRecord
  has_many :users, dependent: :delete_all

  validates :name, presence: true
  validates :target_limit, presence: true, numericality: { greater_than_or_equal_to: -1 }
end
