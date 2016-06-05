# frozen_string_literal: true
require 'elasticsearch/model'

class Message < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  belongs_to :user
  belongs_to :chat
  has_many :notifications, as: :notificationable

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :text, type: :string
    end
  end

  has_many :attaches, as: :attachable, dependent: :destroy
end

# Delete the previous articles index in Elasticsearch
Message.__elasticsearch__.client.indices.delete index: Message.index_name

# Create the new index with the new mapping
Message.__elasticsearch__.client.indices.create index: Message.index_name,
                                                body: {
                                                  settings: Message.settings.to_hash,
                                                  mappings: Message.mappings.to_hash
                                                }
Message.import
