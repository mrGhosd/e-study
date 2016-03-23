require 'rails_helper'

describe Form::Session do
  let!(:user) { create :user }
  let!(:authorization) { create :authorization }
  let!(:user_attributes) do
    {
      email: user.email,
      password: 'example12345',
      authorization: authorization.attributes
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
        expect(Authorization.find_by_jwt_token(form.token)).to eq(authorization)
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
          password: 'example',
          authorization: authorization.attributes
        }
      end
      let!(:form) { ::Form::Session.new(nil, user_attributes) }

      it 'return error with email key' do
        form.submit
        expect(form.errors.messages).to have_key(:email)
      end
    end

    context 'authorization doesn\'t exists' do
      def user_attrs
        {
          email: user.email,
          password: user.password,
          authorization: {
            platform: 'Windows',
            platform_version: '10.11.3',
            app_name: 'Chrome',
            app_version: '49.0.2623.87',
            provider: 'Estudy'
          }
        }
      end

      it 'create new authorization' do
        expect do
          ::Form::Session.new(nil, user_attrs)
        end.to change(Authorization, :count).by(1)
      end
    end
  end
end
