class Form::Chat < Form::Base
  attribute :name
  attribute :owner_id

  validates :owner_id, presence: true
end