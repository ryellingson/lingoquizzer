class MessagesController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   @message = Message.new
  # end

  # def create
  #   @message = Message.create(message_params)
  #   if @message.save
  #     ActionCable.server.broadcast 'chat_channel',
  #                                   content: @message.content
  #   end
  # end


  def create
    @message = Message.new(message_params)
    @message.user = current_user
    if @message.save
      ActionCable.server.broadcast 'chat_channel', content: @message.content
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
