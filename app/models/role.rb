class Role < ActiveRecord::Base

	has_many :project_users

	has_many :permissions

	validates :name,:presence=>true
	validates :name,format: {with: /\A[a-zA-Z]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
	validates_uniqueness_of :name
end
