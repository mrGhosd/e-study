# frozen_string_literal: true
class HomeworkPolicy < ApplicationPolicy
  def create?
    record.course.students.include?(user)
  end

  def show?
    record.user == user ||
      record.lesson.teacher_id == user.id ||
      record.course.author == user
  end

  def update?
    record.user == user || record.course.author == user
  end

  def destroy?
    record.user == user || record.course.author == user
  end
end
