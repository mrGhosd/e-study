module AuthorizationConcern
  extend ActiveSupport::Concern

  included do
    attribute :authorization

    validates :authorization, presence: true

    def authorization=(attr)
      @auth = Authorization.find_by(platform: attr['platform'], app_name: attr['app_name'])
      @auth = Authorization.new if @auth.blank?
      @auth.assign_attributes(attr)
      @auth.save!
      super(@auth)
    end
  end
end
