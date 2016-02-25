class ProjectsController < ApplicationController
    # before_filter :load_and_authorize_resource 
    load_and_authorize_resource :only => [:edit, :show,:destroy]            
    # load_and_authorize_resource                  #common method to restrict all controller methods
    layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      "userportal"
    end
  end


    before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index
      @projects = Project.all
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_param)
      if @project.save
        flash[:notice] = "project created successfully"
        redirect_to projects_path
      else
        render 'new'
      end
    end

    def edit
      # authorize! :edit, @project
    end

    def update
       if @project.update(project_param)
        flash[:notice] = "project updated successfully"
        redirect_to projects_path
      else
        render 'edit'
      end
    end

    def destroy
      # authorize! :destroy, @project
      if @project.destroy
        flash[:notice] = "project deleted successfully"
        redirect_to projects_path
      else
        render 'index'
      end
    end

    def show
      @project = Project.find(params[:id])
       # authorize! :view, @project
    end


    def set_param
      @project = Project.find(params[:id])
    end

    def project_param
      params.require(:project).permit(:pname,:startdate,:enddate,:duedate,:status,:description )
    end

end
