class Form::CourseEnroll
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :course, :student

  validate :course_students_includes_user
  validate :course_lesson_includes_user

  def initialize(course, student)
    @course = course
    @student = student
  end

  def enroll!
    return unless valid?
    ActiveRecord::Base.with_advisory_lock("#{@student.id}_enroll_#{@course.id}") do
      @course.students << @student
    end
  end

  private

  def course_students_includes_user
    if @course.students.include?(@student)
      errors.add(:student, I18n.t('course.errors.student_already_exist'))
      false
    end
  end

  def course_lesson_includes_user
    if @course.teachers.include?(@student)
      errors.add(:student, I18n.t('course.errors.student_teacher'))
      false
    end
  end
end
