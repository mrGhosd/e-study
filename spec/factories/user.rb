FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "useremail#{n}@mail.test"}
    password_digest "12345"
  end
end