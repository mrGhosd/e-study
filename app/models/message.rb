class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  has_many :attaches, as: :attachable, dependent: :destroy
end
