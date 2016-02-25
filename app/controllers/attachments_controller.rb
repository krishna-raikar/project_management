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

  def index
  	@attachment = Attachment.all
  end

  def show
  end

  def create
  	@attachment = Attachment.new(attachment_param)
  	@attachment.save!
  end

  def edit
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
