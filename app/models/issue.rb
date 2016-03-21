class Issue < ActiveRecord::Base

	belongs_to :own_issues, :class_name => 'User',foreign_key: "creator_id"
	belongs_to :assigned_issues, :class_name => 'User',foreign_key: "assignee_id"
	belongs_to :project

	has_one :attachment,as: :attachable
	accepts_nested_attributes_for :attachment 
    

    # validates :avatar, { content_type: ["image/jpeg", "image/gif", "image/png", "image/png"] }
	validates :title,:description,:priority,:severity,:status,:issue_category,:entry_date,:project_id,:creator_id,:presence => true
	validates :title,format: {with: /\A[a-zA-Z]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
	validate :entry_date_check
    
    cat_list = ['bug','feature','support']
	validates_inclusion_of :issue_category, :in => cat_list, :message => 'choose from the available options'

    status_list = ['new','In progres','pending','canceled','completed']
	validates_inclusion_of :status, :in => status_list, :message => 'choose from the available options'

	priority_list = ['urgent','high','medium','low']
	validates_inclusion_of :priority, :in => priority_list, :message => 'choose from the available options'

    severity_list = ['blocker','critical','major','minor','trivial']
	validates_inclusion_of :severity, :in => severity_list, :message => 'choose from the available options'
	
	def entry_date_check
		errors.add(:entry_date,  "not a valid date") if
        !entry_date.blank? and entry_date != Date.today
	end

end
