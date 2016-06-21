# frozen_string_literal: true
class LessonPolicy < ApplicationPolicy
  def destroy?
    record.user == user
  end
end
