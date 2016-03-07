FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "useremail#{n}@mail.test" }
    password "example12345"
    password_confirmation "example12345"
  end
end
