class UsersController<ApplicationController
  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index
        dontshowid = []
        dontshowid[0]=User.select('id').find_by(designation:"admin")
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
        render 'devise/index'
      end
    end

    def show
    	render 'devise/show'
    end


    def set_param
      @user = User.find(params[:id])
    end

    def user_param
      params.require(:user).permit(:firstname,:lastname,:phone,:email,:designation)
    end

end
