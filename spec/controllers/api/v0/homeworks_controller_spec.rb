require 'rails_helper'

describe Api::V0::HomeworksController do
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }
  let!(:homework) { create :homework, course_id: course.id, user_id: course.user_id }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new homework' do
        expect do
          post_with_token auth, :create, course_id: course.id, homework: homework.attributes
        end.to change(Homework, :count).by(1)
      end

      context 'response' do
        before do
          post_with_token auth, :create, course_id: course.id,
                                         homework: homework.attributes
        end
        %w(user_id course_id text).each do |attr|
          it "response contains #{attr}" do
            expect(JSON.parse(response.body)['homework']).to have_key(attr)
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new homework' do
        expect do
          post_with_token auth, :create, course_id: course.id, homework: {}
        end.to change(Homework, :count).by(0)
      end

      context 'error' do
        before do
          post_with_token auth, :create, course_id: course.id,
                                         homework: {}
        end
        %w(user_id course_id text).each do |attr|
          it "errors contains #{attr}" do
            expect(JSON.parse(response.body)['errors']).to have_key(attr)
          end
        end
      end
    end
  end

  describe 'PUT #update' do

  end

  describe 'DELETE #destroy' do

  end
end
