module RequestHelper
  def json
    JSON.parse(response_body)
  end

  def get_with_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(user)
    get path, params, headers
  end

  def post_with_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(user)
    post path, params, headers
  end

  def delete_with_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(user)
    delete path, params, headers
  end

  def put_with_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_access_token(user)
    put path, params, headers
  end

  def get_with_super_admin_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_super_admin_access_token(user)
    get path, params, headers
  end

  def post_with_super_admin_token(user, path, params = {}, headers = {})
    request.headers[SessionConcern::TOKEN_NAME] = retrieve_super_admin_access_token(user)
    post path, params, headers
  end
end
