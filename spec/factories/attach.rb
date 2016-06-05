# frozen_string_literal: true
FactoryGirl.define do
  factory :attach do
    trait :image do
      trait :image do
        file do
          Rack::Test::UploadedFile.new(
            File.join(
              Rails.root, 'app', 'assets', 'images', 'test.jpg'
            )
          )
        end
      end
    end
  end
end
