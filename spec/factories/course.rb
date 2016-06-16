# frozen_string_literal: true
FactoryGirl.define do
  factory :course do
    title 'Title'
    description 'Description'
    slug 'title'
    short_description 'Short Description'
    begin_date Time.zone.now
    end_date Time.zone.now + 1.month
    difficult 'easy'
  end
end
