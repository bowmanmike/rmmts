class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where(sender: current_user) + Conversation.where(receiver: current_user)
    @conversations = @conversations.uniq
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :desc)
    @new_message = current_user.messages.build
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end

    redirect_to conversation_path(@conversation)
  end

  private
  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
