# frozen_string_literal: true
class CoursePolicy < ApplicationPolicy
  def update?
    record.user == user
  end

  def destroy?
    record.user == user
  end
end
