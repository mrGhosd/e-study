class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def facebook
    form = Form::Oauth.new(nil, request.env['omniauth.auth'])
    if form.submit
      sign_in form.user, event: :authentication
      set_flash_message(:notice, :success, kind: 'facebook') if is_navigational_format?
    else
      session["devise.facebook_data"] = request.env["omniauth.auth"]
    end
    redirect_to root_path
  end

  def twitter
    request.env['omniauth.auth'].info.email = params[:email]
    form = Form::Oauth.new(nil, request.env['omniauth.auth'])
    if form.submit && form.user.present?
      sign_in form.user, event: :authentication
      redirect_to root_path
      set_flash_message(:notice, :success, kind: 'twitter') if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"].except("extra")
      redirect_to root_path
    end
  end

  def vkontakte
    form = Form::Oauth.new(nil, request.env['omniauth.auth'])
    if form.submit
      sign_in form.user, event: :authentication
      redirect_to root_path
      set_flash_message(:notice, :success, kind: 'vkontakte') if is_navigational_format?
    else
      session["devise.vkontakte_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

  def instagram
    request.env['omniauth.auth'].info.email = request.env["omniauth.params"]["email"]

    @user = User.from_omniauth(request.env['omniauth.auth'], instagram: true)
    if @user.persisted?
      sign_in @user, event: :authentication
      redirect_to root_path
      set_flash_message(:notice, :success, kind: 'instagram') if is_navigational_format?
    else
      session["devise.twitter_data"] = request.env["omniauth.auth"]
      redirect_to root_path
    end
  end

end