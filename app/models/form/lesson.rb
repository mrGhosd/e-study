class Form::Lesson < Form::Base
  attribute :title
  attribute :description
  attribute :slug

  validates :title, :description, :slug, presence: true

  def submit
    begin
      super
    rescue ActiveRecord::RecordNotUnique, ActiveRecord::StatementInvalid
      errors.add(:slug, I18n.t('lesson.slug_is_not_unique'))
      false
    end
  end
end
