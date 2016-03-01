class UsersController<ApplicationController
  load_and_authorize_resource :only => [:edit, :show,:destroy] 
  layout :user_layout

  def user_layout
    if current_user.role.name=="admin"
      "adminportal"
    else

      # a= request.path
      # a = a.slice(1...a.length)
      # # a="a/b/c/d"
      # # raise a.inspect
      # q= a.slice(0...(a.index('/')))
      # # raise q.inspect
      # unless q.eql?("users")
      #   "userportal"
      # else
        "userportal"
      # end
    end
  end



  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
  
    def index
        dontshowid = []
        dontshowid[0]=User.select('id').find_by(role_id:Role.find_by(name:"admin"))
        dontshowid[1]=current_user.id
        @users = User.where.not(id:dontshowid)
      render 'devise/index'
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
      raise "e".inspect
    	render 'devise/edit'
    end

    def update
       if @user.update(user_param)
        flash[:notice] = "user updated successfully"
        redirect_to users_path
      else
        render 'devise/edit'
      end
    end

    def destroy
      if @user.destroy
        flash[:notice] = "user deleted successfully"
        redirect_to users_path
      else
        render 'devise/index',:layout=>"user_firsthome"
      end
    end

    def show
    	render 'devise/show'
    end


    def set_param
      @user = User.find(params[:id])
    end

    def user_param
      params.require(:user).permit(:firstname,:lastname,:phone,:email,:role_id)
    end

end
