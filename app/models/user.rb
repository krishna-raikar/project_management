class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks

  has_many :project_users
  has_many :projects, through: :project_users

  has_many :own_issues,:class_name=>'Issue',foreign_key: :creator_id
  has_many :assigned_issues,:class_name=>'Issue',foreign_key: :assignee_id
  has_many :projects,through: :issues

  validates_uniqueness_of :email

end
