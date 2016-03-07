class Form::Registration < Form::Base
  include JsonWebToken
  attr_accessor :token
  attribute :email
  attribute :password
  attribute :password_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true, format:     { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
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
      errors.add(:email, 'person with this email already exists')
    end
  end
end
