# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::CommentsController do
  let!(:auth) { create :authorization }

  describe 'Course' do
    let!(:object) { create :course, user_id: auth.user.id }
    it_behaves_like 'comment'
  end

  describe 'Lesson' do
    let!(:course) { create :course, user_id: auth.user.id }
    let!(:object) { create :lesson, course_id: course.id, user_id: auth.user.id }

    it_behaves_like 'comment'
  end

  describe 'Homework' do
    let!(:course) { create :course, user_id: auth.user.id }
    let!(:lesson) { create :lesson, course_id: course.id, user_id: auth.user.id }
    let!(:object) { create :homework, lesson_id: lesson.id, user_id: auth.user.id }

    it_behaves_like 'comment'
  end
end
