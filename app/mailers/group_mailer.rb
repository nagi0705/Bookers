class GroupMailer < ApplicationMailer
  def event_notification(group, user, event)
    @group = group
    @user = user
    @event = event
    mail(to: @user.email, subject: 'New Event Notification')
  end
end
