class Form::Course < Form::Base
  attr_accessor :lessons, :students

  attribute :title
  attribute :description
  attribute :slug
  attribute :short_description
  attribute :begin_date
  attribute :end_date
  attribute :difficult
  attribute :image

  validates :title, :description, :begin_date, :end_date, :difficult, :short_description, :slug, presence: true
  validates :lessons, presence: true

  def attributes=(attributes)
    super(attributes)
    @lessons = attributes.symbolize_keys[:lessons]
    @students = attributes.symbolize_keys[:students]
  end

  def image=(image)
    super(Image.find_by(id: image["id"], attachable_type: @object.class.to_s))
  end

  def submit
    begin
      super do
        create_lessons!
        create_students!
        errors.blank?
      end
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid
      errors.add(:slug, I18n.t('course.errors.slug_is_not_unique'))
      false
    end
  end

  private

  def create_students!
    object.students << object.author
    @students.each do |id|
      student = User.find_by(id: id)
      object.students << student if student.present?
    end if @students.present?
  end

  def create_lessons!
    @lessons.each_with_index do |attr, index|
      lesson = attr.has_key?('id') ? find_lesson(attr['id']) : build_new_lesson
      form = Form::Lesson.new(lesson, attr)
      unless form.submit
        add_errors(form.errors, index)
        false
      end
    end if @lessons.present?
  end

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
