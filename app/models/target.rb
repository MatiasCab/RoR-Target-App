class Target < ApplicationRecord
    belongs_to :topic, presence: true
    belongs_to :user, presence: true

    validates :title, presence: true
    validates :radius, numericality: { greater_than: 0 }
    validates :lat, :lng, presence: true, numericality: true
end
