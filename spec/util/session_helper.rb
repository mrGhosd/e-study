module SessionHelper
  include JsonWebToken

  def retrieve_access_token(auth)
    generate_token_for_user(auth)
  end

  def retrieve_super_admin_access_token(user) # This is used for super admin session creation
    generate_token_for_user(user, true)
  end
end
