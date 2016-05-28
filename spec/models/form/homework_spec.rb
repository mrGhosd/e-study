require 'rails_helper'

describe Form::Homework do
  let!(:user) { create :user }
  let!(:course) { create :course, user_id: user.id }
  let!(:homework) { create :homework, user_id: user.id, course_id: course.id }
  let!(:homework_attrs) do
    {
      text: 'Homework text',
      user_id: user.id,
      course_id: course.id
    }
  end

  describe '#submit' do
    context 'with valid attributes' do
      let!(:form) { Form::Homework.new(Homework.new, homework_attrs) }

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
      let!(:form) { Form::Homework.new(Homework.new, {}) }

      it 'doesn\'t create a new homework' do
        expect do
          form.submit
        end.to change(Homework, :count).by(0)
      end

      context 'errors' do
        before { form.submit }

        %w(text user_id course_id).each do |attr|
          it "form contain #{attr} errors" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
