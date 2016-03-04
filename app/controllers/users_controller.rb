class UsersController<ApplicationController
  load_and_authorize_resource :only => [:index,:edit, :show,:destroy] 
  # layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else
        "userportal"
    end
  end



  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
  
    def index
        dontshowid = []
        dontshowid[0]=User.select('id').find_by(role_id:Role.find_by(name:"admin"))
        dontshowid[1]=current_user.id
        @users = User.where.not(id:dontshowid)
      render 'devise/index',layout: user_layout
    end

    # def new
    #   @user = user.ne
    # end

    # def create
    #   @user = user.new(user_param)
    #   if @user.save
    #     flash[:notice] = "user created successfully"
    #     redirect_to users_path
    #   else
    #     render 'new'
    #   end
    # end

    def edit
      # raise "e".inspect
    	render 'devise/edit',layout: user_layout
      # raise current_user.password.inspect
    end

    def update
      # raise params[:user].inspect
       if @user.update(user_param)
        flash[:notice] = "user updated successfully"
        redirect_to (:back)
      else
        render 'devise/edit',layout: user_layout
      end
    end

    def destroy
      if @user.destroy
        flash[:notice] = "user deleted successfully"
        redirect_to users_path
      else
        render 'devise/index',:layout=>user_layout
      end
    end

    def show
      flag = params[:id].eql?(current_user.id.to_s)
      unless flag
        redirect_to user_path(current_user.id)
      else
    	  render 'devise/show',:layout => user_layout
      end
    end


    def set_param
      # raise current_user.inspect
      if current_user.role.name.eql?("admin")
        @user = User.find_by(id:params[:id])
      else  
        @user = User.find_by(id:current_user.id)
      end
    end

    def user_param
      params.require(:user).permit(:firstname,:lastname,:phone,:email,:role_id,attachment_attributes: [:file,:description])
    end

end