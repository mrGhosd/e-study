class Form::Course < Form::Base
  attribute :title
  attribute :description

  validates :title, :description, presence: true
end
