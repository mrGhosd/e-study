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
      attaches.each do |attach|
        Attach.find_by(id: attach["data"]["id"], attachable_type: attach["data"]["attachable_type"])
              .update(attachable_id: @object.id)
      end if attaches.present?
      $redis.publish 'rtchange', {id: @object.chat.id, obj: MessageSerializer.new(@object).serializable_hash.to_json }.to_json
    end
  end

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
end
