class ProjectUsersController < ApplicationController
  

  layout :user_layout

  def user_layout
    if current_user.designation=="admin"
      "adminportal"
    else
      "userportal"
    end
  end


  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index
      # @project_users = ProjectUser.all
      @project_users = ProjectUser.joins(:project).joins(:user).joins(:role).pluck("projects.pname","users.firstname","roles.name","project_users.id")
    end

    def new
      @project_user = ProjectUser.new
    end

    def create
      @project_user = ProjectUser.new(project_user_param)
      if @project_user.save
        flash[:notice] = "project_user created successfully"
        redirect_to project_users_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
       if @project_user.update(project_user_param)
        flash[:notice] = "project_user updated successfully"
        redirect_to project_users_path
      else
        render 'edit'
      end
    end

    def destroy
      if @project_user.destroy
        flash[:notice] = "project_user deleted successfully"
        redirect_to project_users_path
      else
        render 'index'
      end
    end

    def show
    end


    def set_param
      @project_user = ProjectUser.find(params[:id])
    end

    def project_user_param
      params.require(:project_user).permit(:role_id,:project_id,:user_id )
    end

end
