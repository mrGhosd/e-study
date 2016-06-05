# frozen_string_literal: true
require 'rails_helper'

describe Form::Comment do
  let!(:auth) { create :authorization }

  describe 'Course' do

    let!(:course) { create :course, user_id: auth.user.id }
    let!(:builded_comment) do
      course.comments.build(user_id: auth.user.id)
    end

    let!(:comment_attrs) do
      {
        text: 'awdwad'
      }
    end

    describe '#submit' do
      context 'with valid attributes' do
        let!(:form) { Form::Comment.new(builded_comment, comment_attrs) }

        it 'create new comment' do
          expect do
            form.submit
          end.to change(Comment, :count).by(1)
        end

        it 'form contain last created comment' do
          form.submit
          expect(form.object).to eq(Comment.last)
        end

      end

      context 'with invalid attributes' do
        let!(:form) { Form::Comment.new(builded_comment, {}) }

        it 'doesn\'t create a comment' do
          expect do
            form.submit
          end.to change(Comment, :count).by(0)
        end

        context 'errors' do
          before { form.submit }

          %w(text).each do |attr|
            it "form errors contain #{attr}" do
              expect(form.errors.messages).to have_key(attr.to_sym)
            end
          end
        end
      end
    end
  end
end
