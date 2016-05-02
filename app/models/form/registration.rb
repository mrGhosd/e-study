class Form::Registration < Form::Base
  include PasswordValidation
  include EmailValidation
  include JsonWebToken

  attr_accessor :token
  attribute :email
  attribute :password
  attribute :password_confirmation

  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  def email=(attr)
    super(attr.downcase.strip)
  end

  def submit
    begin
      super do
        @token = generate_token_for_user(@object)
        true
      end
    rescue ActiveRecord::RecordNotUnique
      errors.add(:email, I18n.t('user.errors.user_email_exist'))
    end
  end
end
