class Form::Registration < Form::Base
  include UserValidations
  validates_confirmation_of :password, if: lambda { |m| m.password.present? }

  attribute :email
  attribute :password
  attribute :password_confirmation
end