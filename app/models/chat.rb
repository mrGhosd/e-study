class Chat < ActiveRecord::Base
  has_many :user_chats
  has_many :users, through: :user_chats
  has_many :messages

  scope :active, -> { joins(:user_chats).where(user_chats: { active: true }).uniq }
end
