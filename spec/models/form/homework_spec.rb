# frozen_string_literal: true
require 'rails_helper'

describe Form::Homework do
  let!(:user) { create :user }
  let!(:course) { create :course, user_id: user.id }
  let!(:lesson) { create :lesson, course_id: course.id, user_id: user.id }
  let!(:homework) { create :homework, lesson_id: lesson.id, user_id: course.user_id }
  let!(:builded_homework) do
    course.lessons.find(lesson.id).homeworks.build(user_id: user.id)
  end
  let!(:homework_attrs) do
    {
      text: 'Homework text'
    }
  end

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { Form::Homework.new(builded_homework, homework_attrs) }

      it 'create new homework' do
        expect do
          form.submit
        end.to change(Homework, :count).by(1)
      end

      it 'object contatins the the attrs value' do
        form.submit
        expect(form.object.text).to eq(homework_attrs[:text])
      end
    end

    context 'with invalid attributes' do
      let!(:form) { Form::Homework.new(builded_homework, {}) }

      it 'doesn\'t create a new homework' do
        expect do
          form.submit
        end.to change(Homework, :count).by(0)
      end

      context 'errors' do
        before { form.submit }

        %w(text).each do |attr|
          it "form contain #{attr} errors" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
