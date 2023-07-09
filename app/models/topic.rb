# == Schema Information
#
# Table name: topics
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  image      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_topics_on_name  (name) UNIQUE
#
class Topic < ApplicationRecord
  has_many :targets, dependent: :destroy
  has_many :conversations, dependent: :destroy
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :image, presence: true, format: { with: URI::DEFAULT_PARSER.make_regexp }
end
