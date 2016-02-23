class IssuesController < ApplicationController
  
  layout :user_layout
  
  def user_layout
    if current_user.designation=="admin"
      "adminportal"
    else
      "userportal"
    end
  end


  before_action :set_param, only:[:show,:edit,:view,:destroy,:update]
  def index
    @issues = Issue.all
  end

  def new
    @issue = Issue.new
  end

  def create
    @issue = Issue.new(issue_param)
    if @issue.save
      flash[:notice] = "issue created successfully"
      redirect_to issues_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
     if @issue.update(issue_param)
      flash[:notice] = "issue updated successfully"
      redirect_to issues_path
    else
      render 'edit'
    end
  end

  def destroy
    if @issue.destroy
      flash[:notice] = "issue deleted successfully"
      redirect_to issues_path
    else
      render 'index'
    end
  end

  def show
  end


  def set_param
    @issue = Issue.find(params[:id])
  end

  def issue_param
    params.require(:issue).permit(:title,:issue_category,:description,:priority,:severity,:status,:entry_date,:project_id,:creator_id,:assignee_id )
  end
end
