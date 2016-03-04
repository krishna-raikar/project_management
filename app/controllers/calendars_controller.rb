class CalendarsController < ApplicationController
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
    @cur_proj = Project.find(params[:project_id])
  end

  def index
  	# raise proj_id.in/spect
  	@events = Task.where(project_id:@cur_proj.id,user_id:current_user.id)
  	render :layout => "userportal"
  	# raise @events.inspect
  end
end