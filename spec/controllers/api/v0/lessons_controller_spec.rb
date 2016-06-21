# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::LessonsController do
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }
  let!(:lesson) { create :lesson, user_id: auth.user.id, course_id: course.id }

  describe 'GET #show' do
    context 'response attributes' do
      before { get :show, course_id: course.id, id: lesson.id }

      %w(id title description slug created_at user_id course homeworks).each do |attr|
        it "success response contain #{attr}" do
          expect(response.body).to be_json_eql(lesson.send(attr.to_sym).to_json)
            .at_path("lesson/#{attr}")
        end
      end
    end

    context 'access rights to homeworks' do
      let!(:another_auth) { create :authorization }
      let!(:homework_1) { create :homework, user_id: auth.user.id, lesson_id: lesson.id }
      let!(:homework_2) { create :homework, user_id: another_auth.user.id, lesson_id: lesson.id }

      it 'contain homework only for current_user' do
        get_with_token auth, :show, course_id: course.id, id: lesson.id
        json = JSON.parse(response.body)['lesson']

        expect(json['homeworks'].first['id']).to eq(homework_1.id)
        expect(json['homeworks'].first['id']).not_to eq(homework_2.id)
      end

      it 'contain homework only for another current_user' do
        get_with_token another_auth, :show, course_id: course.id, id: lesson.id
        json = JSON.parse(response.body)['lesson']

        expect(json['homeworks'].first['id']).to eq(homework_2.id)
        expect(json['homeworks'].first['id']).not_to eq(homework_1.id)
      end
    end
  end

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
