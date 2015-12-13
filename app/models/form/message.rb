class Form::Message < Form::Base
  attribute :user_id
  attribute :text
  attribute :chat_id

  def attributes=(attrs)
    super
  end

  def submit
    super
  end
end
