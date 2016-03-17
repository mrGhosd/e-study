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
    ActiveRecord::Base.with_advisory_lock(phone) do
      ActiveRecord::Base.transaction do
        user = User.find_or_create_by(phone: phone)
      end
    end
  end
end
