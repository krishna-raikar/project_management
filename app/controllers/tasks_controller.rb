class TasksController < ApplicationController
  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index
      @tasks = Task.all
    end

    def new
      @task = Task.new
    end

    def create
      @task = Task.new(task_param)
      if @task.save
        flash[:notice] = "task created successfully"
        redirect_to tasks_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
       if @task.update(task_param)
        flash[:notice] = "task updated successfully"
        redirect_to tasks_path
      else
        render 'edit'
      end
    end

    def destroy
      if @task.destroy
        flash[:notice] = "task deleted successfully"
        redirect_to tasks_path
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
      params.require(:task).permit(:name,:startdate,:enddate,:status,:description,:time_spent,:project_id,:user_id,:entry_date)
    end
end
