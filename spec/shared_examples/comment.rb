# frozen_string_literal: true
RSpec.shared_examples 'comment' do
  describe 'POST #create' do

    let!(:attrs) do
      {
        text: 'awdwad',
        type: object.class.to_s.downcase,
        id: object.id
      }
    end

    context 'with valid attributes' do
      it 'create new comment' do
        expect do
          post_with_token auth, :create, comment: attrs
        end.to change(Comment, :count).by(1)
      end

      it 'return new comment' do
        post_with_token auth, :create, comment: attrs
        comment = JSON.parse(response.body)['comment']
        expect(comment['id']).to eq(Comment.last.id)
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create a comment' do
        expect do
          post_with_token auth, :create, comment: {}
        end.to change(attrs[:type].camelize.constantize, :count).by(0)
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
                       commentable_id: object.id,
                       commentable_type: object.class.to_s
    end

    let!(:attrs) do
      {
        text: 'aaa',
        id: object.id,
        type: object.class.to_s.downcase
      }
    end

    context 'with valid attributes' do

      it 'update comment' do
        put_with_token auth, :update, id: comment.id, comment: attrs
        comment.reload
        expect(comment.text).to eq(attrs[:text])
      end

      it 'return updated comment' do
        put_with_token auth, :update, id: comment.id, comment: attrs
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
      create :comment, commentable_id: object.id,
                       commentable_type: object.class.to_s.downcase,
                       user_id: auth.user.id
    end

    it 'delete the comment' do
      expect do
        delete_with_token auth, :destroy, id: comment.id
      end.to change(Comment, :count).by(-1)
    end
  end
end
