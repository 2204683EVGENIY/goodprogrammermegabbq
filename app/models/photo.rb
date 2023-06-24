class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  has_one_attached :photo do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :photo, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"] }

  validates :photo, presence: true

  scope :persisted, -> { where "id IS NOT NULL" }
end
