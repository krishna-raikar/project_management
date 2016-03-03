class PromaxController < ApplicationController
  
  # before_action :authenticate_user!
   # layout :user_layout
   # skip_before_filter :verify_authenticity_token
   autocomplete :project, :pname
   # before_action :authenticate_user!

   def user_layout
    
    if current_user.role.name.eql?("admin")
      "adminportal"
    else
      "userportal"
    end
  end

  def dashboard
  	# raise "entered".inspect
    # raise current_user.projects.count.inspect
    @proj_count=Project.all.count
    @pro_new_count = Project.where(status:"new").count
    @pro_running_count = Project.where(status:"In progres").count
    @pro_complete_count = Project.where(status:"closed").count

    @task_count = Task.count
    @task_new_count = Task.where(status:"new").count
    @task_running_count=Task.where(status:"In progres").count
    @task_finish_count=Task.where(status:"finished").count


    @attach_count = Attachment.all.count
    @user_count = User.all.count - 1
    @emp_count = User.where(role_id: Role.find_by(name: "employee")).count
    @mgr_count = User.where(role_id: Role.find_by(name: "manager")).count

    @user_track = User.all.order("last_sign_in_at desc")

    @issue_bug=current_user.assigned_issues.where(issue_category:"bug").where.not(status:"completed").count
    @issue_feature=current_user.assigned_issues.where(issue_category:"feature").where.not(status:"completed").count
    @issue_support=current_user.assigned_issues.where(issue_category:"support").where.not(status:"completed").count
  
    # @pro_mgr=current_user.projects.first.users.find_by(role_id:Role.find_by(name:"manager"))
    # @team_members = current_user.projects.first.users.where(role_id:Role.find_by(name:"employee")).where.not(id:current_user.id)
    

    @p = request.query_parameters
    @tasks = current_user.tasks.where(project_id:1)
    if @p[:task_query].eql?("all")
      @tasks = current_user.tasks.where(project_id:1)
    elsif @p[:task_query].eql?("imp")
      @tasks=current_user.tasks.where(enddate:Date.today+1,project_id:1)
    elsif @p[:task_query].eql?("com") 
      @tasks=current_user.tasks.where(status:"finished",project_id:1)
    end

   @p = request.query_parameters
    @issues = current_user.assigned_issues.where(project_id:1)
    if @p[:issue_query].eql?("all")
      @issues = current_user.assigned_issues.where(project_id:1)
    elsif @p[:issue_query].eql?("imp")
      @issues=current_user.assigned_issues.where(project_id:1,priority:"urgent")
    elsif @p[:issue_query].eql?("com") 
      @issues=current_user.assigned_issues.where(status:"finished",project_id:1)
    end
    
    # @cur_proj = Project.find(params[:project_id])
    # raise @cur_proj.inspect
    if current_user.role.name.eql?("admin")
       render "admin_dashboard",:layout => user_layout
    else
       render "emp_dashboard",:layout => user_layout
    end
  end

  def index
    # raise current_user.inspect
    render :layout => user_layout
  end


  def welcome
    if user_signed_in?
      redirect_to "/promax"
    end
  end

end
