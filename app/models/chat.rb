class Chat < ActiveRecord::Base
  belongs_to :user, foreign_key: :owner_id
  has_many :user_chats
  has_many :users, through: :user_chats

  has_many :messages
end
