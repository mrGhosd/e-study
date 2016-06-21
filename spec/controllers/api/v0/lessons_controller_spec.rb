# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::LessonsController do
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }
  let!(:lesson) { create :lesson, user_id: auth.user.id, course_id: course.id }

  describe 'DELETE #destroy' do
    it 'destroy lesson' do
      expect do
        delete_with_token auth, :destroy, course_id: course.id, id: lesson.id
      end.to change(Lesson, :count).by(-1)
    end

    context 'access to resource' do
      let!(:another_auth) { create :authorization }
      before { delete_with_token another_auth, :destroy, course_id: course.id, id: lesson.id }

      it 'return error status' do
        expect(response.forbidden?).to be_truthy
      end

      it 'have an error key' do
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
