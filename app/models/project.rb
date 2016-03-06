class Project < ActiveRecord::Base

    has_many :tasks
    
    has_many :project_users,dependent: :destroy
    has_many :users, through: :project_users
    # has_and_belongs_to_many :users

    has_many :issues
    # has_many :users,through: :issues



    validates :pname, :enddate,:startdate,  :duedate, :status, presence: true
	validates :pname,length: { minimum: 3,maximum:30 }, :unless => Proc.new{|f| f.blank?}
	validate :startdate_check
	validate :enddate_check
	validate :duedate_check

   status_list = ['new','In progres','pending','canceled','closed']
	validates_inclusion_of :status, :in => status_list, :message => 'choose from the available options'
    validates_uniqueness_of :pname
		
	def startdate_check
		 errors.add(:startdate,  "can't be in the past") if
         !startdate.blank? and startdate < Date.today
	end

	def enddate_check
		errors.add(:enddate,  "can't be in the past") if
        !enddate.blank? and enddate < Date.today
	end

	def duedate_check
		errors.add(:duedate,  "can't be in the past") if
        !duedate.blank? and duedate < Date.today
	end
end
