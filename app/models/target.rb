# == Schema Information
#
# Table name: targets
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  radius     :float            not null
#  lat        :float            not null
#  lng        :float            not null
#  matched    :boolean          default(FALSE), not null
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
  belongs_to :topic
  belongs_to :user

  has_one :match_users_conversation, dependent: :destroy
  has_one :conversation, through: :match_users_conversation

  validates :title, presence: true
  validates :radius, presence: true, numericality: { greater_than: 0 }
  validates :lat, :lng, presence: true, numericality: true
  validate  :max_target_amount_reached, unless: -> { user.nil? }, on: :create

  MAX_TARGETS_AMOUNT = ENV.fetch('TARGET_CREATION_LIMIT', '3').to_i

  scope :by_topic, ->(topic) { where(topic:) }
  scope :not_same_user, ->(user) { where.not(user:) }
  scope :inside_their_radius, lambda { |lng, lat|
                                where('targets.radius >= ST_Distance(
                                       ST_MakePoint(targets.lng, targets.lat)::geography,
                                       ST_MakePoint(?, ?)::geography)', lng, lat)
                              }
  scope :inside_this_radius, lambda { |radius, lng, lat|
                               where('ST_DWithin(ST_MakePoint(targets.lng, targets.lat)::geography,
                                      ST_MakePoint(?, ?)::geography, ?)', lng, lat, radius)
                             }
  scope :not_matched, -> { where(matched: false) }
  scope :mached_targets, lambda { |target|
    inside_this_radius(target.radius, target.lng, target.lat)
      .by_topic(target.topic)
      .not_same_user(target.user)
      .inside_their_radius(target.lng, target.lat)
      .not_matched
  }

  private

  def max_target_amount_reached
    return unless user.target_limit_reached?

    errors.add(:user,
               I18n.t('api.errors.maximum_targets_reached'))
  end
end
