# frozen_string_literal: true
module OauthRequest
  VK_FIELDS = %(photo_id, email, verified, sex, bdate, city, country,
  home_town, has_photo, photo_50, photo_100, photo_200_orig, photo_200,
  photo_400_orig, photo_max, photo_max_orig, online, lists, domain,
  has_mobile, contacts, site, education, universities, schools, status,
  last_seen, followers_count, common_count, occupation, nickname, relatives,
  relation, personal, connections, exports, wall_comments, activities,
  interests, music, movies, tv, books, games, about, quotes, can_post,
  can_see_all_posts, can_see_audio, can_write_private_message,
  can_send_friend_request, is_favorite, is_hidden_from_feed, timezone,
  screen_name, maiden_name, crop_photo, is_friend, friend_status,
  career, military, blacklisted, blacklisted_by_me)

  def vk_user_info_request(id, token)
    url = "https://api.vk.com/method/account.getProfileInfo?user_id=#{id}
    &v=5.52&access_token=#{token}&fields=#{VK_FIELDS}&scope=email"
    base_request url
  end

  def vk_access_token(code)
    app_id = Rails.application.secrets.vk_app_id
    app_secret = Rails.application.secrets.vk_app_secret
    client_url = Rails.application.secrets.client_url
    url = "https://oauth.vk.com/access_token?client_id=#{app_id}&" \
    "client_secret=#{app_secret}&" \
    "redirect_uri=#{client_url}/oauth/vk&code=#{code}&scope=email"
    base_request url
  end

  private

  def base_request(url)
    url = URI.parse(url)
    req = Net::HTTP::Get.new(url.to_s)
    res = Net::HTTP.start(url.host, url.port,
                          use_ssl: url.scheme == 'https') do |http|
      http.request(req)
    end
    JSON.parse(res.body)
  end
end
