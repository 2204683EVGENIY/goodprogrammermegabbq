class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo

  validates :photo, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"] }

  validates :photo, presence: true

  scope :persisted, -> { where "id IS NOT NULL" }
end
