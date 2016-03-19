class Form::PhoneAuth < Form::Base
  attribute :phone_code
  attribute :country
  attribute :phone

  def country=(attr)
    super(Country.find(attr))
  end

  validates :phone_code, :country, :phone, presence: true
  validates :phone_code, :phone, numericality: true
  validates :phone_code, length: { minimum: 1, maximum: 4 }
  validates :phone, length: { minimum: 10, maximum: 15 }

  def submit
    return unless valid?
    ActiveRecord::Base.with_advisory_lock('Auth') do
      ActiveRecord::Base.transaction do
        user = User.find_or_create_by(phone: phone)
        sms_code = secret_code
        user.update(phone_code: sms_code)
        send_sms_with_code(sms_code)
      end
    end
  end

  private

  def send_sms_with_code(code)
    account_sid = 'ACe39c6a9666430e68107a6221b6a6aec0'
    auth_token = 'b58483b49e944e349dfd953149470141'
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(from: '+15054314056', to: "+#{phone_code}#{phone}", body: "Your confirmation token is #{code}")
  end

  def secret_code
    Random.rand(10000..100000)
  end

  def country_and_code_same?
    if (country.phone_code != phone_code)
      errors.add(:phone_code, 'Doesn\'t match country')
      errors.add(:country, 'Doesn\'t match phone_code')
    end
  end
end
