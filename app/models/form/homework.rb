class Form::Homework < Form::Base
  attribute :text

  validates :text, presence: true
end
