module AuthorizationConcern
  extend ActiveSupport::Concern

  included do
    attr_accessor :auth
    validates :auth, presence: true
  end

  def authorization(attr)
    if attr
      auth = Authorization.find_by(platform: attr['platform'],
                                   app_name: attr['app_name']) || Authorization.new
      form = Form::Authorization.new(auth, attr)
      form.submit
      @auth = form.object
    end
  end
end
