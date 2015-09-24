require 'elasticsearch/model'

class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_one :image, as: :imageable, dependent: :destroy

  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'true' do
      indexes :surname, type: :string
      indexes :name, type: :string
      indexes :email, type: :string
      indexes :secondname, type: :string
      indexes :description, type: :string
    end
  end

  def image_attributes=(attrs)
    self.image = Image.find(attrs["imageable_id"]) if attrs["imageable_id"].present?
  end

  def as_json(params = {})
    super({methods: [:image]}.merge(params))
  end
end
# Delete the previous articles index in Elasticsearch
User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil

# Create the new index with the new mapping
User.__elasticsearch__.client.indices.create index: User.index_name,
  body: { settings: User.settings.to_hash, mappings: User.mappings.to_hash }
User.import
