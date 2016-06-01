class Form::Course < Form::Base
  attr_accessor :lessons

  attribute :title
  attribute :description

  validates :title, :description, presence: true
  validates :lessons, length: { minimum: 1 }

  def attributes=(attributes)
    super(attributes)
    @lessons = attributes['lessons']
  end

  def submit
    super do
      @lessons.each_with_index do |attr, index|
        lesson = attr.has_key?('id') ? find_lesson(attr['id']) : build_new_lesson
        form = Form::Lesson.new(lesson, attr)
        unless form.submit
          add_errors(form.errors, index)
          false
        end
      end if @lessons.present?
      errors.blank?
    end
  end

  private

  def build_new_lesson
    @object.lessons.build(user_id: @object.user_id)
  end

  def find_lesson(id)
    @object.lessons.find(id)
  end

  def add_errors(error, index)
    errors.add(:lessons, { index => error.messages })
    false
  end
end
