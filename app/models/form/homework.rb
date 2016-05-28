class Form::Homework < Form::Base
  attribute :text
  attribute :user_id
  attribute :course_id
  
  validates :text, :user_id, :course_id, presence: true
end
