class Form::Homework < Form::Base
  validates :text, :user_id, :course_id, presence: true
end
