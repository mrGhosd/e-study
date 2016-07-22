# frozen_string_literal: true
class CoursePolicy < ApplicationPolicy
  def update?
    record.author == user
  end

  def destroy?
    record.author == user
  end
end
