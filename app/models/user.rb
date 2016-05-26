require 'elasticsearch/model'

class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_one :image, as: :attachable, dependent: :destroy
  has_one :background_image, as: :attachable, dependent: :destroy
  has_many :notifications
  has_many :authorizations

  has_many :courses

  has_secure_password

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :last_name, type: :string
      indexes :first_name, type: :string
      indexes :email, type: :string
      indexes :middle_name, type: :string
      indexes :description, type: :string
    end
  end

  def self.find_by_jwt_token(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end
end
# Delete the previous articles index in Elasticsearch
User.__elasticsearch__.client.indices.delete index: User.index_name

# Create the new index with the new mapping
User.__elasticsearch__.client.indices.create index: User.index_name,
                                             body: { settings: User.settings.to_hash,
                                                     mappings: User.mappings.to_hash }
User.import
