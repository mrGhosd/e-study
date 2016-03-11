module SessionHelper
  include JsonWebToken

  def retrieve_access_token(user)
    generate_token_for_user(user)
  end

  def retrieve_super_admin_access_token(user) # This is used for super admin session creation
    generate_token_for_user(user, true)
  end
end
