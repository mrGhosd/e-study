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
    @user = User.find_by(email: email)
    @auth.update(user_id: @user.id) if @auth.present?
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
      errors.add(:email, 'There is no such user')
    end
  end
end
