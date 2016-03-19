class Form::PhoneSettings < Form::Base
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
      end
    end
  end

  private

  def generate_phone_token
    account_sid = 'ACe39c6a9666430e68107a6221b6a6aec0'
    auth_token = 'b58483b49e944e349dfd953149470141'
    @client = Twilio::REST::Client.new account_sid, auth_token
    @client.messages.create(from: '+15054314056', to: '+79214438239', body: 'Hey there!')
  end

  def secret_code
    Random.rand(10000..100000)
  end
end
