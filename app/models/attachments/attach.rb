# frozen_string_literal: true
class Attach < ActiveRecord::Base
  mount_uploader :file, FileUploader
  belongs_to :attachable, polymorphic: true
end
