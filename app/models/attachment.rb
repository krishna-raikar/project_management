class Attachment < ActiveRecord::Base
	mount_uploader :file, AvatarUploader

	belongs_to :attachable, polymorphic: true
	# validates :file,presence: true
end
