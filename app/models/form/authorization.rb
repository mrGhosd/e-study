class Form::Authorization < Form::Base
  include UserValidations

  attribute :email
  attribute :password
end