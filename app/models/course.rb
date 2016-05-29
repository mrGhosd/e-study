class Course < ActiveRecord::Base
  belongs_to :user
  has_many :homeworks
  has_many :lessons
end
