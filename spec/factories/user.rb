FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "useremail#{n}@mail.test"}
    password "12345"
    password_confirmation "12345"
  end
end