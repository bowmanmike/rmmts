class ConversationsController < ApplicationController
before_filter :require_login

  def index
    @conversations = Conversation.where(sender: current_user) + Conversation.where(receiver: current_user)
    @conversations = @conversations.uniq
  end

  def show
    @conversation = Conversation.find(params[:id])
    @messages = @conversation.messages.order(created_at: :asc)
    @new_message = current_user.messages.build

    respond_to do |format|
      format.html { render @conversation }
      format.js
    end
  end

  def create
    if Conversation.between(params[:sender_id], params[:receiver_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:receiver_id]).first
    else
      @conversation = Conversation.create(conversation_params)
    end

    redirect_to conversations_path
  end

  private
  def conversation_params
    params.permit(:sender_id, :receiver_id)
  end
end
