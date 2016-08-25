class Form::Registration < Form::Base
  include PasswordValidation
  include EmailValidation
  include JsonWebToken
  include AuthorizationConcern

  attr_accessor :token, :authorization
  attribute :email
  attribute :password
  attribute :password_confirmation

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }
  validates :authorization, presence: true

  def attributes=(attrs)
    super(attrs)
    @authorization = attrs['authorization']
  end

  def email=(attr)
    super(attr.downcase.strip)
  end

  def submit
    begin
      super do
        auth = build_authorizaiton(@authorization, @object)
        @token = generate_token_for_auth(auth)
        true
      end
    rescue ActiveRecord::RecordNotUnique
      errors.add(:email, I18n.t('user.errors.user_email_exist'))
      false
    end
  end
end
