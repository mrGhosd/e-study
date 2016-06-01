class Form::Lesson < Form::Base
  attribute :title
  attribute :description

  validates :title, :description, presence: true
end
