class MessagesController < ApplicationController
  before_filter :require_login

  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end
  before_action :load_messages

  def index
    @message = @conversation.messages.build
  end

  def new
    @message = @conversation.messages.new
  end

  def create
    @message = current_user.messages.build(message_params)
    @message.conversation_id = @conversation.id

    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_path(@conversation) }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.body = "Deleted message."
    respond_to do |format|
      if @message.save
        format.html { redirect_to conversation_path(@message.conversation.id)
                      flash[:notice] = "Your message has been deleted." }
        format.js {}
      else
        format.html { render :new }
        format.js {}
      end
    end
  end

  private
  def message_params
    params.require(:message).permit(:body)
  end

  def load_messages
    @messages = @conversation.messages.order(created_at: :asc)
  end
end
