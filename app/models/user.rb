class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :role
  has_many :tasks
 

  has_one :attachment,as: :attachable
  accepts_nested_attributes_for :attachment
  
  # has_and_belongs_to_many :projects
  has_many :project_users
  has_many :projects, through: :project_users

  has_many :own_issues,:class_name=>'Issue',foreign_key: :creator_id
  has_many :assigned_issues,:class_name=>'Issue',foreign_key: :assignee_id
  # has_many :projects,through: :issues
  

  validates_uniqueness_of :email

  validates :firstname, :lastname, :phone, :email, :role_id, presence: true
  validates :firstname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
  validates :lastname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}

end
