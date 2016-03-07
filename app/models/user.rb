require 'elasticsearch/model'

class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks
  has_one :image, as: :attachable, dependent: :destroy
  has_many :authorizations

  has_many :user_chats
  has_many :chats, through: :user_chats

  has_many :messages

  has_secure_password

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
    self.image = Image.find(attrs['imageable_id']) if attrs['imageable_id'].present?
  end

  def create_authorization(auth)
    authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def self.find_by_jwt_token(token)
    find(JWT.decode(token, nil, false).first['id']) if token
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
# Delete the previous articles index in Elasticsearch
User.__elasticsearch__.client.indices.delete index: User.index_name

# Create the new index with the new mapping
User.__elasticsearch__.client.indices.create index: User.index_name,
                                             body: { settings: User.settings.to_hash,
                                                     mappings: User.mappings.to_hash }
User.import
