class ProjectUser < ActiveRecord::Base

	belongs_to :project
	belongs_to :user
	belongs_to :role

	validates_uniqueness_of :role_id, :scope => [:user_id, :project_id]
end

