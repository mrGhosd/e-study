class Chat < ActiveRecord::Base
  has_one :user
end