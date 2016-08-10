# frozen_string_literal: true
module DateConcern
  def date_of_birth_h
    I18n.l(object.date_of_birth, format: '%d %b %Y') if object.date_of_birth.present?
  end

  def date_of_birth
    object.date_of_birth&.strftime('%d.%m.%Y')
  end
end
