class EventMailer < ApplicationMailer
  def notice_event(user, event)
    @user = user
    @event = event
    mail(to: @user.email, subject: @event.title)
  end
end
