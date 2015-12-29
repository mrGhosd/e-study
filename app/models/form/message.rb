class Form::Message < Form::Base
  attr_accessor :attaches
  attribute :user_id
  attribute :text
  attribute :chat_id

  validate :is_text_empty?

  def attributes=(attrs)
    super
    @attaches = attrs["attaches"]
  end

  def submit
    super do
      attaches.each do |attach|
        Attach.find_by(id: attach["data"]["id"], attachable_type: attach["data"]["attachable_type"])
              .update(attachable_id: attach["data"]["id"])
      end
      $redis.publish 'rtchange', MessageSerializer.new(@object).serializable_hash.to_json
    end
  end

  def is_text_empty?
    if @attaches.blank? && text.blank?
      self.errors.add(:text, "Message text can't be empty")
      false
    end
  end
end
