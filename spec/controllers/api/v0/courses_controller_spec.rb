require 'rails_helper'

describe Api::V0::CoursesController do
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new course' do
        expect do
          post_with_token auth, :create, course: course.attributes
        end.to change(Course, :count).by(1)
      end

      it 'receive new course' do
        post_with_token auth, :create, course: course.attributes
        json = JSON.parse(response.body)['course']['title']
        expect(json).to eq(Course.last.title)
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new course' do
        expect do
          post_with_token auth, :create, course: {}
        end.to change(Course, :count).by(0)
      end

      context 'failed response' do
        before { post_with_token auth, :create, course: {} }

        %w(title description).each do |attr|
          it "course errors contains #{attr}" do
            json = JSON.parse(response.body)['errors']
            expect(json).to have_key(attr)
          end
        end
      end
    end

  end

  describe 'PUT #update' do
    context 'with valid attributes' do
      it 'update a course' do
        put_with_token auth, :update, id: course.id, course: { title: 'aaa', description: 'bbb' }
        course.reload
        expect(course.title).to eq('aaa')
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update a course' do
        put_with_token auth, :update, id: course.id, course: {}
        course.reload
        expect(course.title).to eq(course.title)
      end
    end
  end
end
