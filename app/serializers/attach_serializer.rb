class AttachSerializer < ActiveModel::Serializer
  attributes :id, :attachable_id, :attachable_type, :type, :created_at, :url

  def url
    object.file.url
  end
end
