class EventMailer < ApplicationMailer
  def subscription(event, subscription)
    @email = subscription.user_email
    @name = subscription.user_name
    @event = event

    mail to: event.user.email, subject: "#{I18n.t("event_mailer.subscription.title")} #{ event.title }"
  end

  def comment(comment, email)
    @event = comment.event
    @comment = comment

    mail to: email, subject: "#{I18n.t("event_mailer.comment.title")} #{ comment.event.title }"
  end

  def photo(photo, email)
    @event = photo.event
    @photo = photo

    mail to: email, subject: "#{I18n.t("event_mailer.photo.title")} #{ photo.event.title }"
  end
end
