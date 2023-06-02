class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user, optional: true

  before_validation :downcase_email

  with_options if: -> { user.present? } do
    validates :user, uniqueness: {scope: :event_id}
    validates :user_id, uniqueness: { scope: :event_id }
    validate :user_is_event_maker
  end

  with_options unless: -> { user.present? } do
    validates :user_name, presence: true
    validates :user_email,
              presence: true,
              format: { with: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/ },
              uniqueness: { scope: :event_id }
    validate :email_match
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

  private

  def downcase_email
    user_email&.downcase!
  end

  def email_match
    if User.exists?(email: user_email)
      errors.add(:user_email, :taken)
    end
  end

  def user_is_event_maker
    if user_id == event.user.id
      errors.add(:user_id, :subserror)
    end
  end
end
