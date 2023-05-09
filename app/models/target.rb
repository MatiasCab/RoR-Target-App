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
    belongs_to :user

    validates :title, presence: true
    validates :radius, :lat, :lng, presence: true, numericality: true
end
