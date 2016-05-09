class Form::Session < Form::Base
  include PasswordValidation
  include EmailValidation
  include JsonWebToken
  include AuthorizationConcern

  attr_accessor :token
  attribute :email
  attribute :password

  def attributes=(attrs)
    super(attrs)
    @user = ::User.find_by(email: email)
    authorization(attrs[:authorization].merge(user_id: @user.id))
    if @auth.present? && @user.present?
      @auth.update(user_id: @user.id)
    end
  end

  def submit
    return unless valid?
    authorization!
  end

  private

  def authorization!
    if @user && @user.authenticate(password)
      @token = generate_token_for_auth(@auth)
    else
      errors.add(:email, I18n.t('user.errors.user_doesnt_exist'))
      false
    end
  end
end
