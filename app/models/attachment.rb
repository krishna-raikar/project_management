class Attachment < ActiveRecord::Base
	mount_uploader :file, AvatarUploader

	belongs_to :attachable, polymorphic: true
end
