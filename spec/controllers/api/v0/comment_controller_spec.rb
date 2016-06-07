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

    describe 'PUT #update' do
      let!(:comment) do
        create :comment, user_id: auth.user.id,
                         commentable_id: course.id,
                         commentable_type: course.class.to_s
      end

      let!(:comment_atts) do
        {
          text: 'aaa',
          id: course.id,
          type: 'comment'
        }
      end

      context 'with valid attributes' do

        it 'update comment' do
          put_with_token auth, :update, id: comment.id, comment: comment_attrs
          comment.reload
          expect(comment.text).to eq(comment_attrs[:text])
        end

        it 'return updated comment' do
          put_with_token auth, :update, id: comment.id, comment: comment_attrs
          comment.reload
          expect(JSON.parse(response.body)['comment']['id']).to eq(comment.id)
        end
      end

      context 'with invalid attributes' do
        it 'doesn\'t update comment' do
          put_with_token auth, :update, id: comment.id, comment: {}
          comment.reload
          expect(comment.text).to eq(comment.text)
        end

        context 'error response' do
          before { put_with_token auth, :update, id: comment.id, comment: {} }

          %w(text).each do |attr|
            it "error response contain #{attr}" do
              expect(JSON.parse(response.body)['errors']).to have_key(attr)
            end
          end
        end
      end
    end

    describe 'DELETE #destroy' do
      let!(:comment) do
        create :comment, commentable_id: course.id,
                         commentable_type: course.class.to_s,
                         user_id: auth.user.id
      end

      it 'delete the comment' do
        expect do
          delete_with_token auth, :destroy, id: comment.id
        end.to change(Comment, :count).by(-1)
      end
    end
  end
end
