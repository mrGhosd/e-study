require 'elasticsearch/model'

class Chat < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_many :user_chats
  has_many :users, through: :user_chats
  has_many :messages

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :messages, type: :nested do
        indexes :text, type: :string
      end

      indexes :users, type: :nested do
        indexes :last_name, type: :string
        indexes :first_name, type: :string
        indexes :email, type: :string
        indexes :middle_name, type: :string
        indexes :description, type: :string
      end
    end
  end

  scope :active, -> { joins(:user_chats).where(user_chats: { active: true }).uniq }

  def as_indexed_json(options = {})
    if options.present?
      as_json(options.merge(include: [:users, :messages]))
    else
      as_json(
        include: [:users, :messages]
      )
    end
  end
end
# Delete the previous articles index in Elasticsearch
Chat.__elasticsearch__.client.indices.delete index: Chat.index_name rescue nil

# Create the new index with the new mapping
Chat.__elasticsearch__.client.indices.create index: Chat.index_name,
                                             body: { settings: Chat.settings.to_hash,
                                                     mappings: Chat.mappings.to_hash }
Chat.import
