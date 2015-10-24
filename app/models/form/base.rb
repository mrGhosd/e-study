class Form::Base
  include Tainbox
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming
  attr_reader :object

  delegate :persisted?, to: :object

  def initialize(object, params = nil)
    @object = object
    self.attributes = params || @object.attributes
  end

  def to_model
    object
  end

  def submit(&block)
    return unless valid?

    @object.assign_attributes(attributes)
    ActiveRecord::Base.with_advisory_lock(@object.class.to_s) do
      ActiveRecord::Base.transaction do
        block.call if block_given?
        @object.save!
      end
    end
  end
end