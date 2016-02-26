class AttachmentsController < ApplicationController
  load_and_authorize_resource :only => [:edit, :show,:destroy] 
  before_save :check_data

  layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      "userportal"
    end
  end

  def index
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


    def check_data
      raise "e".inspect
    end
end
