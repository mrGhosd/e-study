
url = URI.parse('https://restcountries.eu/rest/v1/all')
req = Net::HTTP::Get.new(url.to_s)
res = Net::HTTP.start(url.host, url.port, use_ssl: true) { |http| http.request(req) }
countries_json = JSON.parse(res.body)
countries_json.each do |country|
  Country.create!(name: country['name'], phone_code: country['callingCodes'].first)
end
