# frozen_string_literal: true
class CoursePolicy < ApplicationPolicy
  def update?
    record.user == user
  end

  def destroy?
  end
end
