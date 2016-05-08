class Form::Oauth::Vk < Form::Base
  include AuthorizationConcern
  include JsonWebToken
  attribute :email

  attr_accessor :user, :token, :vk_attributes

  def attributes=(attrs)
    super(attrs)
    @user = User.find_by(email: attrs['email'])
    @auth = attrs['auth'].merge({ 'user_id' => @user.id, 'provider' => 'Vkontakte'  })
    authorization(@auth)
    if @user.blank?
      @vk_attributes = vk_user_info_request(attrs['user_id'], attrs['access_token'])
    end
  end

  def submit
    return unless valid?
    if @user.present?
      @token = generate_token_for_auth(@auth)
    end
  end
end
