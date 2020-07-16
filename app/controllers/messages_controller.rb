class MessagesController < ConversationsController
  before_action :authenticate_user!, :set_online_users

  def index
    if params[:lang]
      @messages = @language.messages.order(created_at: :desc).limit(100).reverse
      skip_policy_scope
    else
      @messages = policy_scope(Message).order(created_at: :desc).limit(100).reverse
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
      ActionCable.server.broadcast('chat_channel', content: render_to_string(partial: 'messages/message', locals: { message: @message }))
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :language_id)
  end
end
