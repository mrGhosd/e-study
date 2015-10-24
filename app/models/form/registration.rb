class Form::Registration < Form::Base
  attribute :email
  attribute :password
  attribute :password_confirmation

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence:   true, format:     { with: VALID_EMAIL_REGEX }
  validates :password, length: { minimum: 6 }
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  def submit
    super
  end
end