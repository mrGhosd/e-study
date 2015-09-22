class Form::User < Form::Base
  attribute :email, String
  attribute :surname, String
  attribute :name, String
  attribute :secondname, String
  attribute :date_of_birth, Time
  attribute :description, String

  validates :surname, :name, :secondname, :date_of_birth, presence: true
  validates_format_of :email, with: /.+@.+\..+/

  def image=(image)
    super(Image.find_by(imageable_id: image["imageable_id"], imageable_type: @object.class.to_s))
  end
end