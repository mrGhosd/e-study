# frozen_string_literal: true
require 'rails_helper'

describe Form::Course do
  let!(:user) { create :user }
  let!(:course) { create :course, user_id: user.id }

  let!(:teacher) { create :user }

  let!(:lesson_attrs) do
    {
      title: 'Lesson title',
      description: 'Lesson description',
      slug: 'new-slug',
      teacher_id: teacher.id
    }
  end

  let!(:course_attrs) do
    {
      title: 'New title',
      description: 'New description',
      slug: 'another-title',
      short_description: 'Short description',
      lessons: [lesson_attrs],
      difficult: 'easy',
      begin_date: Time.zone.now,
      end_date: Time.zone.now
    }
  end

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Course.new(user.courses.build, course_attrs) }

      it 'create new course' do
        expect do
          form.submit
        end.to change(Course, :count).by(1)
      end

      it 'form object contain just created course' do
        form.submit
        expect(form.object.title).to eq(course_attrs[:title])
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Course.new(user.courses.build, {}) }

      it 'doesn\'t create a new course' do
        expect do
          form.submit
        end.to change(Course, :count).by(0)
      end

      context 'error keys' do
        before { form.submit }

        %w(title description).each do |attr|
          it "form contain #{attr} errors" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
