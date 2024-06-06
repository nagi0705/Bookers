# app/controllers/conversations_controller.rb
class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.new(conversation_params)
      if @conversation.save
        redirect_to conversation_path(@conversation)
      else
        redirect_to conversations_path, alert: @conversation.errors.full_messages.join(", ")
      end
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages
  end

  private

  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
