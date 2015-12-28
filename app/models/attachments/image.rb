class Image < Attach
  mount_uploader :file, ImageUploader
  belongs_to :imageable, polymorphic: true
end
