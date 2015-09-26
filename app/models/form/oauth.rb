class Form::Oauth < Form::Base
  attribute :info
  attribute :provider
  attribute :uid
  attribute :user

  def submit
    return authorization.user if authorization
    ActiveRecord::Base.with_advisory_lock(@object.class.to_s) do
      ActiveRecord::Base.transaction do
        @user = User.find_by(email: @info.email)
        if @user.blank?
          create_new_user
        end
        create_authorization
      end
    end
  end

  def authorization
    @authorization ||= Authorization.where(provider: @provider, uid: @uid.to_s).first
  end

  def create_authorization
    @user.authorizations.create(provider: @provider, uid: @uid.to_s)
  end

  def create_new_user
    splitted_name = @info.name.split(" ")
    avatar = Image.new(imageable_type: "User")
    avatar.remote_file_url = @provider.eql?("facebook") ? @info.image.gsub("http","https") : @info.image
    password = Devise.friendly_token[0, 20]
    user_params = {email: @info.email, password: password, password_confirmation: password,
                   name: splitted_name.first, surname: splitted_name.last, image: avatar}
    # user_params = user_params.merge({remote_avatar_url: auth.extra.raw_info.photo_200_orig}) if auth.extra.raw_info.present?
    # user_params = user_params.merge({nickname: nickname}) if instagram
    @user = User.new(user_params)
    @user.save
  end
end