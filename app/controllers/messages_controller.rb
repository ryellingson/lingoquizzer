class MessagesController < ApplicationController
  before_action :authenticate_user!, :set_online_users

  def index
    if params[:lang]
      @language = Language.find_by(language_code: params[:lang])
      @messages = @language.messages.order(created_at: :desc).limit(5)
      skip_policy_scope
    else
      @messages = policy_scope(Message).order(created_at: :desc).limit(5)
    end
    render layout: "conversations"
  end

  def create
    @message = Message.new(message_params)
    @message.user = current_user
    avatar = {
      content: current_user.avatar.attached? ? current_user.avatar.service_url : current_user.default_avatar,
      default: !current_user.avatar.attached?
    }
    authorize @message
    if @message.save
      ActionCable.server.broadcast 'chat_channel', content: @message.content, username: current_user.username, created_at: @message.created_at.strftime("%l:%M %p"), avatar: avatar
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :language_id)
  end
end
