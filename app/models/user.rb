class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[ github vkontakte ]

  has_many :events, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :photos, dependent: :destroy

  has_one_attached :avatar

  validates :avatar, blob: { content_type: ["image/png", "image/jpg", "image/jpeg"] }

  validates :name, presence: true, length: { maximum: 35 }

  before_validation :set_name, on: :create
  before_validation :downcase_email

  after_commit :link_subscriptions, on: :create

  def self.find_for_oauth(access_token, provider)
    email = access_token.info.email
    name = access_token.info.name

    oauth_avatar = if provider == "Vkontakte"
                     access_token.extra.raw_info.photo_400_orig
                   else
                     access_token.info.image
                   end

    user = User.find_or_initialize_by(email: email.downcase)

    return user if user.persisted?

    user.assign_attributes(
      email: email,
      name: name,
      oauth_avatar: oauth_avatar
      password: Devise.friendly_token.first(16),
    )

    user.save

    user
  end

  private

  def set_name
    self.name = "#{I18n.t("controllers.users.comrad")}#{rand(777)}" if self.name.blank?
  end

  def link_subscriptions
    Subscription.where(user_id: nil, user_email: self.email).update_all(user_id: self.id)
  end

  def downcase_email
    email&.downcase!
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end
end
