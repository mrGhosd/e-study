class Form::Attach < Form::Base
  attribute :type
  attribute :attachable_id
  attribute :attachable_type
  attribute :file

  def initialize(object, params = nil)
    @object = object.constantize
    self.attributes = params || @object.attributes
  end
end
