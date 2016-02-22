class Permission < ActiveRecord::Base

	belongs_to :role

	validates :modelname,:role_id,:per_list,:presence=> true

	validates_uniqueness_of :id,:scope=>[:modelname,:role_id]

end
