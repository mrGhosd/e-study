# frozen_string_literal: true
#
# url = URI.parse('https://restcountries.eu/rest/v1/all')
# req = Net::HTTP::Get.new(url.to_s)
# res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }
# countries_json = JSON.parse(res.body)
# countries_json.each do |country|
#   Country.create!(name: country['name'], phone_code: country['callingCodes'].first)
# end

# Users
20.times do
  user = User.create!(first_name: Faker::Name.first_name,
                      middle_name: Faker::Name.first_name,
                      last_name: Faker::Name.last_name,
                      password: 'Altair_69',
                      password_confirmation: 'Altair_69',
                      email: Faker::Internet.email,
                      date_of_birth: Faker::Date.between(45.years.ago, Time.zone.today))
  img = Image.new(attachable_type: 'User', attachable_id: user.id, type: 'Image')
  img.remote_file_url = Faker::Avatar.image
  img.save
end
