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
    unless request.path.eql?("/attachments")
      @cur_proj = Project.find(params[:project_id])
    end
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
    @attachments = Attachment.all
    
  end

  def show
  end

  def create
    raise "entered".inspect
  	@attachment = Attachment.new(attachment_param)
  	@attachment.save!
  end

  def edit
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
