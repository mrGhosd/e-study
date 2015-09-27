class Chat < ActiveRecord::Base
  belongs_to :user
  has_many :user_chats
  has_many :users, through: :user_chats
end