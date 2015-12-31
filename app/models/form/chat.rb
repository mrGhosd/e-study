class Form::Chat < Form::Base
  attr_accessor :users

  def initialize(object, params = nil)
    super(object, params)
  end

  def attributes=(attrs)
    super(attrs)
    @users = attrs["users"]
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
    end
  end
end
