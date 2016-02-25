class RolesController < ApplicationController

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
    def index
      @roles = Role.where.not(name:"admin")
    end

    def new
      @role = Role.new
    end

    def create
      @role = Role.new(role_param)
      if @role.save
        flash[:notice] = "role created successfully"
        redirect_to roles_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
       if @role.update(role_param)
        flash[:notice] = "role updated successfully"
        redirect_to roles_path
      else
        render 'edit'
      end
    end

    def destroy
      if @role.destroy
        flash[:notice] = "role deleted successfully"
        redirect_to roles_path
      else
        render 'index'
      end
    end

    def show
    end


    def set_param
      @role = Role.find(params[:id])
    end

    def role_param
      params.require(:role).permit(:name,:description)
    end
end
