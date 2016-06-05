# frozen_string_literal: true
require 'rails_helper'

describe Api::V0::CommentsController do
  let!(:auth) { create :authorization }

  describe 'Course' do
    let!(:course) { create :course, user_id: auth.user.id }
    let!(:comment_attrs) do
      {
        text: 'awdwad',
        type: 'course',
        id: course.id
      }
    end

    describe 'POST #create' do
      context 'with valid attributes' do
        it 'create new comment' do
          expect do
            post_with_token auth, :create, comment: comment_attrs
          end.to change(Comment, :count).by(1)
        end

        it 'return new comment' do
          post_with_token auth, :create, comment: comment_attrs
          comment = JSON.parse(response.body)['comment']
          expect(comment['id']).to eq(Comment.last.id)
        end
      end

      context 'with invalid attributes' do
        it 'doesn\'t create a comment' do
          expect do
            post_with_token auth, :create, comment: {}
          end.to change(Comment, :count).by(0)
        end

        context 'errors' do
          before { post_with_token auth, :create, comment: {} }

          %w(text).each do |attr|
            it "errors list include #{attr} key" do
              expect(JSON.parse(response.body)['errors']).to have_key(attr)
            end
          end
        end
      end
    end
  end
end
