class IssuesController < ApplicationController
  load_and_authorize_resource :only => [:edit, :show,:destroy] 
  layout :user_layout
  
  def user_layout
    if current_user.role.name == "admin"
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

  def view_filter
    # raise "e".inspect
    # puts Issue.last.to_json
    # render :json=> Issue.last
    # render :partial => 'table', :collection => @issues
    redirect_to :issues
  end


  def index
    a=request.query_parameters
    #if true show ownedissues otherwise assigned issues
    if current_user.role.name!="admin"
      # raise "e".inspect

      if a[:view_flag].eql?("true")
        puts "true"
        @issues = current_user.own_issues
      else
        puts "false"
        @issues = current_user.assigned_issues
      end  
    else
      @issues = Issue.all
    end
     # render partial: "hello"
     # render :partial => 'table', :collection => 
  end

  def new
    @issue = Issue.new
  end

  def create
    
    @issue = Issue.new(issue_param)
    if @issue.save
      flash[:notice] = "issue created successfully"
      redirect_to project_issues_path
    else
      render 'new'
    end
  end

  def edit
  end

  def update
     if @issue.update(issue_param)
      flash[:notice] = "issue updated successfully"
      redirect_to project_issues_path
    else
      render 'edit'
    end
  end

  def destroy
    if @issue.destroy
      flash[:notice] = "issue deleted successfully"
      redirect_to project_issues_path
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
    params.require(:issue).permit(:title,:issue_category,:description,:priority,:severity,:status,:entry_date,:project_id,:creator_id,:assignee_id,attachment_attributes: [:file,:description] )
  end
end
