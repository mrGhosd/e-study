class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_one :image, as: :imageable, dependent: :destroy

  accepts_nested_attributes_for :image

  def image_attributes=(attrs)
    self.image = Image.find(attrs["imageable_id"]) if attrs["imageable_id"].present?
  end

  def as_json(params = {})
    super({methods: [:image]}.merge(params))
  end
end
