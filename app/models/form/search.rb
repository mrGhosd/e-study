class Form::Search < Form::Base
  DEFAULT_LIMIT_SIZE = 10
  DEFAULT_CHAT_LIMIT = 20
  DEFAULT_MESSAGES_LIMIT = 20

  attribute :object
  attribute :query

  def search
    if query.present?
      object.camelize.constantize.search("*#{query}*").records.to_a
    else
      object.camelize.constantize.limit(DEFAULT_LIMIT_SIZE)
    end
  end

  def search_chats
    scope = object.chats
    if query.present?
      scope.search("*#{query}*").records.to_a
    else
      scope.limit(DEFAULT_CHAT_LIMIT)
    end
  end

  def search_messages
    scope = object.messages
    if query.present?
      scope.search("*#{query}*").records.to_a
    else
      scope.limit(DEFAULT_MESSAGES_LIMIT)
    end
  end
end
