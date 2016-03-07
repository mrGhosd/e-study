require 'rails_helper'

describe Form::User do
  let!(:user) { create :user }
  let!(:user_attributes) do
    {
      email: user.email,
      first_name: 'Example',
      last_name: 'Example',
      middle_name: 'date',
      date_of_birth: Time.zone.today.to_s
    }
  end

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::User.new(user, user_attributes) }

      before { form.submit }

      it 'update user info' do
        user.reload
        expect(user.first_name).to eq(user_attributes[:first_name])
      end

      it 'form object contain updated user' do
        expect(form.object.first_name).to eq(user_attributes[:first_name])
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::User.new(user, {}) }

      before { form.submit }

      it 'doesn\'t update user' do
        user.reload
        expect(user.first_name).to eq(nil)
      end

      %w(last_name first_name middle_name date_of_birth email).each do |attr|
        it "form erros containt #{attr}" do
          expect(form.errors.messages).to have_key(attr.to_sym)
        end
      end
    end

    context 'with image' do
      let!(:attach) { create :attach, :image, attachable_type: 'User', type: 'Image' }
      let!(:user_attributes) do
        {
          email: user.email,
          first_name: 'Example',
          last_name: 'Example',
          middle_name: 'date',
          date_of_birth: Time.zone.today.to_s,
          image: { 'id' => attach.id }
        }
      end
      let!(:form) { ::Form::User.new(user, user_attributes) }

      it 'attach image to user' do
        form.submit
        user.reload
        expect(user.image.id).to eq(attach.id)
      end
    end
  end
end
