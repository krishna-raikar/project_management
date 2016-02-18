class Task < ActiveRecord::Base
	
	belongs_to :project
	belongs_to :user



	validates :name, :startdate, :enddate, :status,:description,:project_id,:entry_date, presence: true
	validates :name,format: {with: /\A[a-zA-Z]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
	validate :startdate_check
	validate :enddate_check
	validate :entrydate_check

   status_list = ['new','In progres','pending','rejected','finished']
	validates_inclusion_of :status, :in => status_list, :message => 'choose from the available options'

		
	def startdate_check
		 errors.add(:startdate,  "can't be in the past") if
         !startdate.blank? and startdate < Date.today
	end

	def enddate_check
		errors.add(:enddate,  "can't be in the past") if
        !enddate.blank? and enddate < Date.today
	end

	def entrydate_check
		errors.add(:entry_date,  "can't be in the past") if
        !entry_date.blank? and entry_date != Date.today
	end
end
