class AttachesSerializer < ActiveModel::Serializer
  attributes :id, :attachable_id, :attachable_type, :type, :created_at, :file
end
