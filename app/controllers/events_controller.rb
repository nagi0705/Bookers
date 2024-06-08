class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group
  before_action :verify_owner, only: [:new, :create]

  def new
    @event = @group.events.build
  end

  def create
    @event = @group.events.build(event_params)
    @event.user = current_user
    if @event.save
      GroupMailer.event_notification(@group, @event).deliver_now
      redirect_to @group, notice: 'Event was successfully created and notification sent.'
    else
      render :new
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def verify_owner
    unless @group.owner == current_user
      redirect_to @group, alert: 'Only the group owner can create events.'
    end
  end

  def event_params
    params.require(:event).permit(:title, :content)
  end
end
