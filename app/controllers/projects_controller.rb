class ProjectsController < ApplicationController
    # before_filter :load_and_authorize_resource 
    load_and_authorize_resource :only => [:edit, :show,:destroy]            
    # load_and_authorize_resource                  #common method to restrict all controller methods
    
  layout :user_layout
  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      # unless request.path.eql?("/projects")
      # raise "e".inspect
      "userportal" 
      # "user_firsthome"
    # else
      # "user_firsthome"
      # end
    end
  end


    before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index

      unless current_user.role.name.eql?("admin")
        @projects = current_user.projects      
        # render template:@projects
         render "index_emp"
      else
        unless params[:search_text].nil?
          @projects = Project.where(pname:params[:search_text])
        else 
          @projects = Project.all
        end
        render "index_emp",layout: user_layout
      end

    end

    def new
      @project = Project.new
    end

    def create
      # raise params[:project].inspect
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
      render layout: user_layout
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
      # render :layout=>user_layout
      @project = Project.find(params[:id])

      # # raise @project.inspect
      # unless current_user.role.name.eql?("admin")       
         render "show_emp",:layout=>user_layout
      # end
      #  # authorize! :view, @project
    end

    def overview
    # raise "entered".inspect
    # raise current_user.projects.count.inspect
    @cur_proj = Project.find(params[:id])
    @proj_count=current_user.projects.count
    @pro_new_count = current_user.projects.where(status:"new").count
    @pro_running_count = current_user.projects.where(status:"In progres").count
    @pro_complete_count = current_user.projects.where(status:"closed").count

    @task_count = current_user.tasks.count
    @task_new_count = current_user.tasks.where(status:"new").count
    @task_running_count=current_user.tasks.where(status:"In progres").count
    @task_finish_count=current_user.tasks.where(status:"finished").count

    @issue_bug=current_user.assigned_issues.where(issue_category:"bug",project_id:@cur_proj.id).where.not(status:"completed").count
    @issue_feature=current_user.assigned_issues.where(issue_category:"feature",project_id:@cur_proj.id).where.not(status:"completed").count
    @issue_support=current_user.assigned_issues.where(issue_category:"support",project_id:@cur_proj.id).where.not(status:"completed").count
    
    @pro_mgr=current_user.projects.find(@cur_proj.id).users.find_by(role_id:Role.find_by(name:"manager"))
    @team_members = current_user.projects.find(@cur_proj.id).users.where(role_id:Role.find_by(name:"employee")).where.not(id:current_user.id)
    # raise @pro_mgr.inspect

    @p = request.query_parameters
    @tasks = current_user.tasks.where(project_id:@cur_proj.id)
    if @p[:task_query].eql?("all")
      @tasks = current_user.tasks.where(project_id:@cur_proj.id)
    elsif @p[:task_query].eql?("imp")
      @tasks=current_user.tasks.where(enddate:Date.today+1,project_id:@cur_proj.id)
    elsif @p[:task_query].eql?("com") 
      @tasks=current_user.tasks.where(status:"finished",project_id:@cur_proj.id)
    end

   @p = request.query_parameters
    @issues = current_user.assigned_issues.where(project_id:@cur_proj.id)
    if @p[:issue_query].eql?("all")
      @issues = current_user.assigned_issues.where(project_id:@cur_proj.id)
    elsif @p[:issue_query].eql?("imp")
      @issues=current_user.assigned_issues.where(project_id:@cur_proj.id,priority:"urgent")
    elsif @p[:issue_query].eql?("com") 
      @issues=current_user.assigned_issues.where(status:"finished",project_id:@cur_proj.id)
    end
    
    # @cur_proj = Project.find(params[:project_id])
    # raise @cur_proj.inspect
    if current_user.role.name.eql?("admin")
       render "admin_dashboard",:layout => user_layout
    else
       render "emp_dashboard",:layout => user_layout
    end
  end


    def set_param
      @project = Project.find(params[:id])
    end

    def project_param
      params.require(:project).permit(:pname,:startdate,:enddate,:duedate,:status,:description )
    end

end
