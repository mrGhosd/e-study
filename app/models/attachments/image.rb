class Image < Attach
  mount_uploader :file, ImageUploader
end
