class Form::Message < Form::Base
  attr_accessor :attaches
  attribute :user_id
  attribute :text
  attribute :chat_id

  validate :is_text_empty?

  def attributes=(attrs)
    super
    find_or_create_chat(attrs) if @object.chat.blank?
    @attaches = attrs["attaches"]
  end

  def submit
    super do
      @attaches.each do |attach|
        Attach.find_by(id: attach["id"], attachable_type: attach["attachable_type"])
              .update(attachable_id: @object.id)
      end if @attaches.present?
      write_message_to_redis
    end
  end

  private

  def is_text_empty?
    if @attaches.blank? && text.blank?
      self.errors.add(:text, "Message text can't be empty")
      false
    end
  end

  def find_or_create_chat(attrs)
    users = attrs["users"].join(", ")
    finded_chats = UserChat.in_same_chat(users)
    if finded_chats.present?
      chat_id = finded_chats.map(&:chat_id).uniq.first
    else
      chat = Chat.create!
      attrs["users"].each { |u| chat.users << User.find(u) }
      chat_id = chat.id
    end
    self.chat_id = chat_id
  end

  def write_message_to_redis
    chat_id = @object.chat.id
    message = MessageSerializer.new(@object).serializable_hash.to_json
    user_in_chat = @object.chat.users.map { |u| u.id }
    $redis.publish 'rtchange', { chat_id: chat_id, action: 'chatmessage',
      obj: message, chat_users: user_in_chat }.to_json
  end
end
