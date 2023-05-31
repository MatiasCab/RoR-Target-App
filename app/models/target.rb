# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  radius     :float            not null
#  lat        :float            not null
#  lng        :float            not null
#  user_id    :bigint           not null
#  topic_id   :bigint           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_targets_on_topic_id  (topic_id)
#  index_targets_on_user_id   (user_id)
#
class Target < ApplicationRecord
  acts_as_mappable

  belongs_to :topic
  belongs_to :user

  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :lat, :lng, presence: true, numericality: true
  validate  :max_target_amount_reached, unless: -> { user.nil? }

  MAX_TARGETS_AMOUNT = ENV.fetch('TARGET_CREATION_LIMIT', '3').to_i

  scope :mached_targets, -> (target) { 
    where(topic: target.topic)
      .where.not(user: target.user)
      .within(target.radius, origin: target)
      #.select { |t| t.radius >= t.distance_from(target) } #no me gusta mucho
  }

  private

  def max_target_amount_reached
    return if user.targets.count < MAX_TARGETS_AMOUNT

    errors.add(:user,
               I18n.t('api.errors.maximum_targets_reached'))
  end

  def distance
    puts self.radius
    true
    #puts Geokit::LatLng.distance_between([target.lat, target.lng], [self.lat, self.lng])
  end
end
