class NotifySubscribersJob < ApplicationJob
  queue_as :default

  def perform(object)
    all_emails = (object.event.subscriptions.map(&:user_email) + [object.event.user.email] - [object.user&.email])

    if object.is_a?(Photo)
      all_emails.each do |mail|
        EventMailer.photo(object, mail).deliver_later
      end
    else
      all_emails.each do |mail|
        EventMailer.comment(object, mail).deliver_later
      end
    end
  end
end
