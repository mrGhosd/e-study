# frozen_string_literal: true
class LessonPolicy < ApplicationPolicy
  def show?
    record.user == user ||
      record.teacher_id == user.id ||
      record.course.students.include?(user)
  end

  def destroy?
    record.user == user
  end
end
