class Form::Lesson < Form::Base
  attribute :title
  attribute :description
  attribute :slug
  attribute :image

  validates :title, :description, :slug, presence: true

  def image=(attr)
    super(Image.find_by(id: attr["id"], attachable_type: @object.class.to_s))
  end

  def submit
    begin
      super
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid
      errors.add(:slug, I18n.t('lesson.slug_is_not_unique'))
      false
    end
  end
end
