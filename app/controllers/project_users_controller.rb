class ProjectUsersController < ApplicationController
  
  load_and_authorize_resource :only => [:edit, :show,:destroy] 
   before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
  layout :user_layout
  before_action :set_proj
  
  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      "userportal"
    end
  end
  


  def set_proj
    @cur_proj = Project.find(params[:project_id])
  end

 
    def index
       if current_user.role.name!="admin"
         @project_users = ProjectUser.where(project_id:@cur_proj).joins(:project).joins(:user).pluck("projects.pname","users.firstname","project_users.id","project_users.user_id")
       else
          a=request.query_parameters
          if a[:view_flag].eql?("true")
            @project_users = ProjectUser.joins(:project).joins(:user).pluck("projects.pname","users.firstname","project_users.id","project_users.user_id")
          else
            @project_users = ProjectUser.where(project_id:@cur_proj).joins(:project).joins(:user).pluck("projects.pname","users.firstname","project_users.id","project_users.user_id")
          end 
         
       end      
    end

    def new
      @project_user = ProjectUser.new
    end

    def create
      # raise params[:project_user][:user_id].inspect
      emp_list = params[:project_user][:user_id]
      proj = @cur_proj.id

      #first delete existing project users if any
      a = ProjectUser.where(project_id:@cur_proj)
      projs=a.where.not("user_id=? and project_id=?",current_user.id,proj)
      # raise projs.inspect
      ProjectUser.delete_all(id:projs.pluck(:id))

      emp_list.each do |e|
         # raise e.inspect
         next if e.eql?("")
          @project_user = ProjectUser.new(user_id:e,project_id:proj)
          unless @project_user.save!
            render 'new' 
            return
          end
      end
      flash[:notice] = "project_user created successfully"
      redirect_to project_project_users_path
      # else
      #   render 'new'
      # end
    end

    def edit
    end

    def update
      
       if @project_user.update(project_user_param)
        flash[:notice] = "project_user updated successfully"
        redirect_to project_project_users_path
      else
        render 'edit'
      end
    end

    def destroy
      if @project_user.destroy
        flash[:notice] = "project_user deleted successfully"
        redirect_to project_project_users_path
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
      if action_name.eql?("update")
         params.require(:project_user).permit(:project_id,:user_id)
      else
         params.require(:project_user).permit(:project_id,:user_id=>[])
      end
    end

end
