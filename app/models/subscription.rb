class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  before_validation :downcase_email

  validates :event, presence: true

  validates :user_name, presence: true, unless: -> { user.present? }

  validates :user, uniqueness: {scope: :event_id}, if: -> { user.present? }

  validates :user_email,
            presence: true,
            format: { with: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/ },
            uniqueness: { scope: :event_id },
            unless: -> { user.present? }

  validates :user_id, uniqueness: { scope: :event_id }, if: -> { user.present? }

  validate :email_match, unless: :user_present?

  def downcase_email
    user_email&.downcase!
  end

  def email_match
    if User.exists?(email: user_email)
      errors.add(:user_email, :taken)
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def user_name
    if user.present?
     user.name
    else
     super
    end
  end

  def user_present?
    user.present?
  end
end
