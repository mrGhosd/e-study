require 'rails_helper'

describe Form::Registration do
  def user_attributes
    {
      email: 'example@mail.com',
      password: 'password1234',
      password_confirmation: 'password1234'
    }
  end

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Registration.new(::User.new, user_attributes) }

      it 'create new user' do
        expect do
          form.submit
        end.to change(User, :count).by(1)
      end

      context 'success submit' do
        before { form.submit }

        it 'return a token' do
          expect(form.token).not_to eq(nil)
        end

        it 'decode token equal to user' do
          expect(User.find_by_jwt_token(form.token)).to eq(User.last)
        end
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Registration.new(::User.new, {}) }

      it 'doesn\'t create a user' do
        expect do
          form.submit
        end.to change(User, :count).by(0)
      end

      context 'failure submit' do
        before { form.submit }

        %w(email password).each do |attr|
          it "failure submit have #{attr} key" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end

    # TODO fix or return it
    # context 'user already exists' do
    #   let!(:user) { create :user }
    #   let!(:user_attributes) do
    #     {
    #       email: user.email,
    #       password: 'password1234',
    #       password_confirmation: 'password1234'
    #     }
    #   end
    #   let!(:form) { ::Form::Registration.new(::User.new, user_attributes) }
    #
    #   it 'return error with `email`' do
    #     form.submit
    #     expect(form.errors.messages).to have_key(:email)
    #   end
    # end
  end
end
