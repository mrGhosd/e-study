# frozen_string_literal: true
require 'rails_helper'

describe Form::Attach do
  let!(:user) { create :user }
  let!(:file) do
    Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'app', 'assets', 'images', 'test.jpg')
    )
  end

  def attach_params
    {
      file: file,
      attachable_type: 'User',
      type: 'Image'
    }
  end

  describe 'submit' do
    context 'with valid attributes' do
      let!(:form) { ::Form::Attach.new(attach_params[:type], attach_params) }

      it 'create new attach' do
        expect do
          form.submit
        end.to change(Attach, :count).by(1)
      end

      it 'change images count' do
        expect do
          form.submit
        end.to change(Image, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let!(:form) { ::Form::Attach.new(attach_params[:type], {}) }

      it 'doesn\'t create a new attach' do
        expect do
          form.submit
        end.to change(Attach, :count).by(0)
      end

      context 'failure submit' do
        before { form.submit }

        %w(attachable_type file type).each do |attr|
          it "error form message contains #{attr} key" do
            expect(form.errors.messages).to have_key(attr.to_sym)
          end
        end
      end
    end
  end
end
