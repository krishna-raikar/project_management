class TasksController < ApplicationController

  load_and_authorize_resource :only => [:edit, :show,:destroy] 
  layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
      "userportal"
    end
  end


  
  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
  before_action :set_proj

  def set_proj
    @cur_proj = Project.find(params[:project_id])
  end

    def index
      
      if current_user.role.name!="admin"
        @tasks = current_user.tasks
      else
        @tasks = Task.all
      end
      # raise @tasks.inspect
    end

    def new
      @task = Task.new
    end

    def create

      @task = @cur_proj.tasks.new(task_param)
      if @task.save
        flash[:notice] = "task created successfully"
        redirect_to project_tasks_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
       if @task.update(task_param)
        flash[:notice] = "task updated successfully"
        redirect_to project_tasks_path
      else
        render 'edit'
      end
    end

    def destroy
      if @task.destroy
        flash[:notice] = "task deleted successfully"
        redirect_to project_tasks_path
      else
        render 'index'
      end
    end

    def show
    end


    def set_param
      @task = Task.find(params[:id])
    end

    def task_param
      param=params.require(:task).permit(:name,:startdate,:enddate,:status,:description,:time_spent,:project_id,:user_id,:entry_date)
      p=param.merge(:entry_date=>Date.today) 
    end
end
