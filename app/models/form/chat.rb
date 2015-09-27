class Form::Chat < Form::Base
  attribute :name
  attribute :owner_id

  validates :owner_id, presence: true

  def submit
    super do
      @object.user_chats.create!(user_id: @owner_id)
    end
  end
end