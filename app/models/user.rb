require 'elasticsearch/model'

class User < ActiveRecord::Base
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  has_many :chats, foreign_key: :owner_id
  has_one :image, as: :imageable, dependent: :destroy
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

  def self.from_omniauth(auth, instagram: false)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    return authorization.user if authorization
    email = auth.info.email
    user = User.find_by email: email
    binding.pry
    if user
      user.create_authorization(auth)
    else
      if instagram
        auth.extra.raw_info = {photo_200_orig: auth.info.image}
        nickname = {nickname: auth.info.nickname}
      end
      password = Devise.friendly_token[0, 20]
      user_params = {email: email, password: password, password_confirmation: password,
                     name: auth.info.first_name, surname: auth.info.last_name,
                     city: auth.info.location}
      user_params = user_params.merge({remote_avatar_url: auth.extra.raw_info.photo_200_orig}) if auth.extra.raw_info.present?
      user_params = user_params.merge({nickname: nickname}) if instagram
      user = User.create!(user_params)
      user.create_authorization(auth)
    end
    user
  end

  def image_attributes=(attrs)
    self.image = Image.find(attrs["imageable_id"]) if attrs["imageable_id"].present?
  end

  def create_authorization(auth)
    self.authorizations.create(provider: auth.provider, uid: auth.uid.to_s)
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

  def create_remember_token
    self.remember_token = User.encrypt(User.new_remember_token)
  end
end
# Delete the previous articles index in Elasticsearch
User.__elasticsearch__.client.indices.delete index: User.index_name rescue nil

# Create the new index with the new mapping
User.__elasticsearch__.client.indices.create index: User.index_name,
  body: { settings: User.settings.to_hash, mappings: User.mappings.to_hash }
User.import
