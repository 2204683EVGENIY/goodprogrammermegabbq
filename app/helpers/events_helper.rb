module EventsHelper
  def is_subscriber?
    [@event.subscribers, [@event.user]].flatten.include?(current_user)
  end
end
