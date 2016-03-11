require 'rails_helper'

describe Api::V0::AttachesController do
  let!(:user) { create :user }
  let!(:file) do
    Rack::Test::UploadedFile.new(
      File.join(Rails.root, 'app', 'assets', 'images', 'test.jpg')
    )
  end

  def attachment_attributes
    {
      file: file,
      type: 'Image',
      attachable_type: 'User'
    }
  end

  describe 'POST #create' do
    context 'with valida attributes' do
      it 'create new attachment' do
        expect do
          post :create, attachment_attributes
        end.to change(Attach, :count).by(1)
      end

      context 'success response' do
        before { post :create, attachment_attributes }

        %w(attachable_type attachable_id type).each do |attr|
          it "success attachment response contain #{attr}" do
            expect(response.body).to be_json_eql(Image.last.send(attr)
                                     .to_json).at_path("attach/#{attr}")
          end
        end
      end
    end

    context 'with invalid attributes' do
      it 'doesn\'t create new attach' do
        expect do
          post :create, type: 'Image'
        end.to change(Attach, :count).by(0)
      end

      context 'failure response' do

        before { post :create, type: 'Image' }

        %w(attachable_type file).each do |attr|
          it "failure attachment response contain #{attr}" do
            expect(JSON.parse(response.body)).to have_key(attr)
          end
        end
      end
    end
  end
end
