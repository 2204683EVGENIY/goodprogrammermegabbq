class Subscription < ApplicationRecord
  EMAIL_REGEXP = /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/.freeze

  belongs_to :event
  belongs_to :user, optional: true

  before_validation :downcase_email

  with_options if: -> { user.present? } do
    validates :user_id, uniqueness: { scope: :event_id }
    validate :self_event_subscription
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email,
              presence: true,
              format: { with: EMAIL_REGEXP },
              uniqueness: { scope: :event_id }
    validate :existing_user_email_presence
  end

  def user_email
    if user.present?
      user&.email || super
    end
  end

  def user_name
    if user.present?
      user&.name || super
    end
  end

  private

  def downcase_email
    user_email&.downcase!
  end

  def existing_user_email_presence
    if User.exists?(email: user_email)
      errors.add(:user_email, :taken)
    end
  end

  def self_event_subscription
    if user_id == event.user.id
      errors.add(:user_id, :unable_self_event_subscription)
    end
  end
end
