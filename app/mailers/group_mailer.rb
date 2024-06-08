class GroupMailer < ApplicationMailer
  def event_notification(group, event)
    @group = group
    @event = event
    mail(to: @group.users.pluck(:email), subject: "New Event in #{@group.name}")
  end
end
