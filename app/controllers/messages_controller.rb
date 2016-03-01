class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    @messages = @conversation.messages
    @message = @conversation.messages.build
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id
    if @message.save
      redirect_to conversation_path(@conversation)
    else
      render :new
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end
end
