require 'rails_helper'

describe Form::Session do
  let!(:user) { create :user }
  let!(:user_attributes) do
    {
      email: user.email,
      password: 'example12345'
    }
  end

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Session.new(nil, user_attributes) }

      it 'return new token' do
        form.submit
        expect(form.token).not_to eq(nil)
      end

      it 'encoded token equal to user' do
        form.submit
        expect(User.find_by_jwt_token(form.token)).to eq(user)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Session.new(nil, {}) }

      before { form.submit }

      %w(email password).each do |attr|
        it "error list contain #{attr} attribute" do
          expect(form.errors.messages).to have_key(attr.to_sym)
        end
      end
    end

    context 'user doesn\'t exists' do
      let!(:user_attributes) do
        {
          email: user.email,
          password: 'example'
        }
      end
      let!(:form) { ::Form::Session.new(nil, user_attributes) }

      it 'return error with email key' do
        form.submit
        expect(form.errors.messages).to have_key(:email)
      end
    end
  end
end
