class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook,:google_oauth2]

      def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
          # raise "e".inspect
          idval = User.connection.select_value("Select nextval('users_id_seq')")
          user.update_attributes(id:idval)
          user.provider = auth.provider
          user.uid = auth.uid
          user.email = auth.info.email
          if auth.provider.eql?("facebook")
            a=auth.info.name
            first=a.slice(0...a.index(" "))
            last =a.slice(a.index(" ")+1...a.length)
            user.update_attributes(firstname:first)
            user.update_attributes(lastname:last) 
          else
            user.update_attributes(firstname:auth.info.first_name)
            user.update_attributes(lastname:auth.info.last_name) 
          end
          user.update_attributes(role_id:2)
          user.password = Devise.friendly_token[0,20]
        end
      end

    # before_save {
      
    # next_id=User.connection.select_value("Select nextval('users_id_seq')")
    # # raise next_id.inspect
    # # raise "b".inspect
    # }




  belongs_to :role
  has_many :tasks,dependent: :destroy
 

  has_one :attachment,as: :attachable
  accepts_nested_attributes_for :attachment
  
  # has_and_belongs_to_many :projects
  has_many :project_users,dependent: :destroy
  has_many :projects, through: :project_users

  has_many :own_issues,:class_name=>'Issue',foreign_key: :creator_id
  has_many :assigned_issues,:class_name=>'Issue',foreign_key: :assignee_id
  # has_many :projects,through: :issues
  

  validates :email, uniqueness: true

  # validates :firstname, :email, :role_id, presence: true
  validates :firstname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
  validates :lastname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
end
