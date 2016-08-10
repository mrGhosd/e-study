# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::CoursesController do
  let!(:teacher) { create :user }
  let!(:auth) { create :authorization }
  let!(:course) { create :course, user_id: auth.user.id }
  let!(:lesson) { create :lesson, user_id: auth.user.id, course_id: course.id }

  let!(:lesson_attrs) do
    {
      title: 'lesson title',
      description: 'Lesson description',
      slug: 'another-lesson-title',
      teacher_id: teacher.id
    }
  end

  let!(:course_attrs) do
    {
      title: 'Super title',
      description: 'Desc',
      slug: 'super-slug',
      short_description: 'Short description',
      lessons: [lesson_attrs],
      difficult: 'easy',
      begin_date: Time.zone.now,
      end_date: Time.zone.now
    }
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'create new course' do
        expect do
          post_with_token auth, :create, course: course_attrs
        end.to change(Course, :count).by(1)
      end

      it 'receive new course' do
        post_with_token auth, :create, course: course_attrs
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
        put_with_token auth, :update, id: course.id, course: course_attrs
        course.reload
        expect(course.title).to eq(course_attrs[:title])
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t update a course' do
        put_with_token auth, :update, id: course.id, course: {}
        course.reload
        expect(course.title).to eq(course.title)
      end
    end

    context 'different user try to update course' do
      let!(:another_auth) { create :authorization }

      before do
        put_with_token another_auth, :update, id: course.id, course: course_attrs
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
    it 'destroy the course' do
      expect do
        delete_with_token auth, :destroy, id: course.id
      end.to change(Course, :count).by(-1)
    end

    context 'different user try to update course' do
      let!(:another_auth) { create :authorization }

      before do
        delete_with_token another_auth, :destroy, id: course.id
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
