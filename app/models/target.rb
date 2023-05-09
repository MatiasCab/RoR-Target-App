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
class Target < ApplicationRecord
    belongs_to :topic

    validates :title, presence: true
    validates :radius, presence: true, numericality: true
    validates :lat, presence: true, numericality: true
    validates :lng, presence: true, numericality: true
    validates :topic_id, presence: true, numericality: true
end
