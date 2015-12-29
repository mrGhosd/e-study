class Form::Attach < Form::Base
  attribute :type
  attribute :attachable_id
  attribute :attachable_type
  attribute :file

  validates :type, :attachable_type, :file, presence: true

  def initialize(object, params = nil)
    @object = object.constantize.new
    self.attributes = params || @object.attributes
  end

  def attributes=(attrs)
    super(attrs)
  end
end
