class Task < ActiveRecord::Base
	
	belongs_to :project
	belongs_to :user



	validates :name, :startdate, :enddate, :status,:description,:project_id, presence: true
	validates :name,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
	validate :startdate_check
	validate :enddate_check
	

   status_list = ['new','In progres','pending','rejected','finished']
	validates_inclusion_of :status, :in => status_list, :message => 'choose from the available options'

		
	def startdate_check
		 errors.add(:startdate,  "can't be in the past") if
         !startdate.blank? and startdate < Date.today
	end

	def enddate_check
		errors.add(:enddate,  "is not valid") if
        !enddate.blank? and enddate < startdate
	end

	

       	 # alias_attribute :start_time, :startdate ##Where 'start' is a attribute of type 'Date' accessible through MyModel's relationship

end
