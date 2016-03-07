class Form::Chat < Form::Base
  attr_accessor :users, :message

  validate :message_exists?

  def attributes=(attrs)
    super(attrs)
    @users = attrs["users"]
    @message = attrs["message"]
    user_chat = UserChat.where(user_id: attrs["users"], active: false).first
    if user_chat
      user_chat.update(active: true)
      @object = user_chat.chat
    end
  end

  def submit
    super do
      @users.each do |user|
        user_chat = UserChat.find_by(chat_id: @object.id, user_id: user)
        self.object.users << User.find(user) if user_chat.blank?
      end
      ::Message.create(chat_id: @object.id, user_id: @users.last, text: @message)
    end
  end

  private

  def message_exists?
    errors.add(:message, "Message text can't be empty") if @message.blank?
  end
end
