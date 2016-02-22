class ProjectsController < ApplicationController

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
      if @project.destroy
        flash[:notice] = "project deleted successfully"
        redirect_to projects_path
      else
        render 'index'
      end
    end

    def show
    end


    def set_param
      @project = Project.find(params[:id])
    end

    def project_param
      params.require(:project).permit(:pname,:startdate,:enddate,:duedate,:status,:description )
    end

end
