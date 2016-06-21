# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::HomeworksController do
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }
  let!(:lesson) { create :lesson, course_id: course.id, user_id: auth.user.id }
  let!(:homework) { create :homework, lesson_id: lesson.id, user_id: course.user_id }

  describe 'GET #show' do
    context 'success response' do
      before do
        get_with_token auth, :show, course_id: course.id, lesson_id: lesson.id,
                                    id: homework.id
      end

      %w(id text created_at user_id lesson comments).each do |attr|
        it "response contain #{attr}" do
          expect(response.body).to be_json_eql(homework.send(attr.to_sym).to_json)
            .at_path("homework/#{attr}")
        end
      end

      it 'contain course value' do
        json = JSON.parse(response.body)['homework']
        expect(json['course']['id']).to eq(homework.lesson.course.id)
      end
    end

    context 'access error' do
      let!(:another_auth) { create :authorization }
      before do
        get_with_token another_auth, :show, course_id: course.id, lesson_id: lesson.id,
                                            id: homework.id
      end

      it 'return error status' do
        expect(response.forbidden?).to be_truthy
      end

      it 'have an error key' do
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new homework' do
        expect do
          post_with_token auth, :create, course_id: course.id,
                                         lesson_id: lesson.id,
                                         homework: homework.attributes
        end.to change(Homework, :count).by(1)
      end

      context 'response' do
        before do
          post_with_token auth, :create, course_id: course.id,
                                         lesson_id: lesson.id,
                                         homework: homework.attributes
        end
        %w(text).each do |attr|
          it "response contains #{attr}" do
            expect(JSON.parse(response.body)['homework']).to have_key(attr)
          end
        end

        it 'belongs_to created user' do
          expect(Homework.last.user).to eq(auth.user)
        end

        it 'belongs_to created lesson' do
          expect(Homework.last.lesson).to eq(lesson)
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new homework' do
        expect do
          post_with_token auth, :create, course_id: course.id,
                                         lesson_id: lesson.id, homework: {}
        end.to change(Homework, :count).by(0)
      end

      context 'error' do
        before do
          post_with_token auth, :create, course_id: course.id,
                                         lesson_id: lesson.id,
                                         homework: {}
        end
        %w(text).each do |attr|
          it "errors contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'updates homework' do
        put_with_token auth, :update, course_id: course.id,
                                      lesson_id: lesson.id,
                                      id: homework.id, homework: { text: '111' }
        homework.reload
        expect(homework.text).to eq('111')
      end

      context 'response' do
        before do
          put_with_token auth, :update, course_id: course.id,
                                        lesson_id: lesson.id,
                                        id: homework.id,
                                        homework: { text: '111' }
        end

        %w(text).each do |attr|
          it "response contains #{attr}" do
            expect(JSON.parse(response.body)['homework']).to have_key(attr)
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update homework' do
        put_with_token auth, :update, course_id: course.id,
                                      lesson_id: lesson.id,
                                      id: homework.id, homework: {}
        homework.reload
        expect(homework.text).to eq(homework.text)
      end

      context 'error' do
        before do
          put_with_token auth, :update, course_id: course.id,
                                        lesson_id: lesson.id,
                                        id: homework.id, homework: {}
        end

        %w(text).each do |attr|
          it "error contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end

    context 'access error' do
      let!(:another_auth) { create :authorization }
      before do
        put_with_token another_auth, :update, course_id: course.id,
                                              lesson_id: lesson.id, id: homework.id,
                                              homework: { text: '111' }
      end

      it 'return error status' do
        expect(response.forbidden?).to be_truthy
      end

      it 'have an error key' do
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroy the homework' do
      expect do
        delete_with_token auth, :destroy, course_id: course.id,
                                          lesson_id: lesson.id,
                                          id: homework.id
      end.to change(Homework, :count).by(-1)
    end

    context 'access error' do
      let!(:another_auth) { create :authorization }
      before do
        delete_with_token another_auth, :destroy, course_id: course.id,
                                                  lesson_id: lesson.id,
                                                  id: homework.id
      end

      it 'return error status' do
        expect(response.forbidden?).to be_truthy
      end

      it 'have an error key' do
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
