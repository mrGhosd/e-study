# frozen_string_literal: true
class Image < Attach
  mount_uploader :file, ImageUploader
end
