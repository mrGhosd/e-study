# frozen_string_literal: true
module UserValidations
  extend ActiveSupport::Concern

  included do
    validates :first_name, :last_name, :middle_name, presence: true
    EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence:   true,
                      format:     { with: EMAIL_REGEX },
                      uniqueness: { case_sensitive: false }
    validates :password, length: { minimum: 6 }
  end
end
