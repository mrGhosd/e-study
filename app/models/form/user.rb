class Form::User < Form::Base
  attribute :email, String
  attribute :last_name, String
  attribute :first_name, String
  attribute :middle_name, String
  attribute :date_of_birth
  attribute :description, String
  attribute :image

  validates :last_name, :first_name, :middle_name, :date_of_birth, :email, presence: true
  validates_format_of :email, with: /.+@.+\..+/

  def image=(image)
    super(Image.find_by(id: image["id"], attachable_type: @object.class.to_s))
  end

  def date_of_birth=(date)
    super(DateTime.parse(date))
  end
end
