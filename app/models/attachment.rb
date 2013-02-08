class Attachment < ActiveRecord::Base
  belongs_to :user

  attr_accessible :attachment
  mount_uploader :attachment, AttachmentUploader
end
