class UserChat < ActiveRecord::Base
  belongs_to :user
  belongs_to :chat

  scope :in_same_chat, -> (users) { find_by_sql("select * from user_chats where
  chat_id in (select chat_id from user_chats group by chat_id having count(*) > 1)
  and user_id in (#{users});") }
end
