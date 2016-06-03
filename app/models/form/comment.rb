class Form::Comment < Form::Base
  attribute :text

  validates :text, presence: true
end
