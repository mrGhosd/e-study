class Form::Message < Form::Base
  attr_accessor :writer, :responder, :chat
  attribute :user_id
  attribute :text
  attribute :chat_id

  def attributes=(attrs)
    super
    find_chat(attrs)
    self.chat_id = @chat.id
  end

  def submit
    super do
      if @chat.new_record?
        @chat.users << [@writer, @responder]
        @chat.save
      end

    end
  end


  private
  def find_chat(attrs)
    user_chats = UserChat.in_same_chat([attrs['user_id'], attrs['responder_id']].join(', '))
    @chat = user_chats.present? ? ::Chat.find(user_chats.map(&:chat_id).uniq.first) : ::Chat.new
    if @chat.new_record?
      @writer = ::User.find(attrs['user_id'])
      @responder = ::User.find('responder_id')
    end
  end
end