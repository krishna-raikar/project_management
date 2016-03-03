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
          user.update_attributes(firstname:auth.info.first_name)
          user.update_attributes(lastname:auth.info.last_name) 
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

  # validates :firstname, :email, :role_id, presence: true
  validates :firstname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}
  validates :lastname,format: {with: /\A[a-zA-Z0-9]{2,20}\Z/}, :unless => Proc.new{|f| f.blank?}

end
