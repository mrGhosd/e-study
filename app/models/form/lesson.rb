class Form::Lesson < Form::Base
  attribute :title
  attribute :description
  attribute :slug
  attribute :image
  attribute :teacher_id

  validates :title, :description, :slug, :teacher_id, presence: true

  def image=(attr)
    super(Image.find_by(id: attr["id"], attachable_type: @object.class.to_s)) if attr.present?
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
