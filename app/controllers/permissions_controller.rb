class PermissionsController < ApplicationController
  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
    def index
      @permissions = Permission.all
    end

    def new
      @permission = Permission.new
    end

    def arr_to_json
      @a = params[:permission][:per_list]
      # @b = @a.map { |e| {e => e} }
      s = @a.to_json

      # vals = JSON.parse  s
      # raise s.inspect
      t = permission_param
       t[:per_list]=s
      return t 
    end


    def create    
      @permission = Permission.new(arr_to_json)
      if @permission.save
        flash[:notice] = "permission created successfully"
        redirect_to permissions_path
      else
        render 'new'
      end
    end

    def edit
    end

    def update
       if @permission.update(arr_to_json)
        flash[:notice] = "permission updated successfully"
        redirect_to permissions_path
      else
        render 'edit'
      end
    end

    def destroy
      if @permission.destroy
        flash[:notice] = "permission deleted successfully"
        redirect_to permissions_path
      else
        render 'index'
      end
    end

    def show
    end


    def set_param
      @permission = Permission.find(params[:id])
    end

    def permission_param
      params.require(:permission).permit(:modelname,:per_list,:role_id)
    end
end
