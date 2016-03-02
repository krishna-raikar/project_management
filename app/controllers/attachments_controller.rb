class AttachmentsController < ApplicationController
  load_and_authorize_resource :only => [:edit, :show,:destroy] 

  layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      "userportal"
    end
  end
  before_action :set_proj

  def set_proj
    # raise request.path.inspect
    
    # a= request.path
    #   a = a.slice(1...a.length)
    #   # a="a/b/c/d"
    #   # raise a.inspect
    #   if
    #   q= a.slice(0...(a.index('/')))
    #   # raise q.inspect
    #  if q.eql?("projects")
    a = request.path
    if a.include? "projects" and (a.include? "attachments" or a.include? "attachment")
        @cur_proj = Project.find(params[:project_id])
    end
    # end
  end


  def index
  	# @attachments = Project.find(3).issues.joins(:attachment).pluck("attachments.*")
    k=0
    @attachments = []
    Project.find(@cur_proj.id).issues.each do | i |
       unless i.attachment.nil?
        @attachments[k] = i.attachment
        k=k+1; 
       end
    end
    # @s = "avatar1.jpeg".to_file
    # raise @attachments.inspect
  end

  def show_all
    @attachments = Attachment.where(attachable_type: "Issue")
    
  end

  def show
  end

  def create
    # raise "entered".inspect
  	@attachment = Attachment.new(attachment_param)
    @attachment.update_attributes(attachable_id:current_user.id,attachable_type:"User")
  	@attachment.save!
    redirect_to(:back)
  end

  def edit
    # raise @attachment.inspect
  end

  def update
     @attachment = Attachment.find(params[:id])

      # raise params[:attachment][:file].inspect
      @attachment.update(file:params[:attachment][:file])
      redirect_to(:back)
  end


  def destroy
    @attachment.delete
    redirect_to :attachments
  end
  def new
  	@attachment = Attachment.new
  end

  def set_param
      @attachment = Attachment.find(params[:id])
    end

    def attachment_param
      params.require(:attachment).permit(:file,:description)
    end

end
