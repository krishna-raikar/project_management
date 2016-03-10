class IssuesDatatable
  delegate :params, :can?, :link_to,:current_user,:project_issue_path,:edit_project_issue_path, to: :@view

  def initialize(view)
    @view = view
    # raise params[:project_id].inspect
  end

  def as_json(options = {})
    {
      sEcho: params[:sEcho].to_i,
      iTotalRecords: Issue.count,
      iTotalDisplayRecords: issues.total_entries,
      aaData: data
    }
  end

private

  def data
    @cur_proj = Project.find(params[:project_id])
    issues.map do |issue|
      [
        issue.id,
        issue.issue_category,
        issue.title,
        issue.description,
        test(issue)
        # link_to "edit", edit_users_path(user),
        # link_to "delete", users_path(user), method: :delete, data: { confirm: 'Are you sure?' }) 
      ]
    end
  end

  def test(obj)
    abc = []
    abc << link_to("show", [@cur_proj,obj], {:remote => true,:class=>"showbtn"}) if can? :show, obj
    abc << link_to("edit", edit_project_issue_path(@cur_proj,obj)) if can? :edit, obj
    abc << link_to("delete", [@cur_proj,obj], method: :delete, data: { confirm: 'Are you sure?' }) if can? :destroy, obj
    abc
  end

  def issues
    @issues ||= fetch_issues
  end

  def fetch_issues
    # raise "entered".inspect
    if params[:view_flag].eql?("false")
       issues = current_user.assigned_issues.order("#{sort_column} #{sort_direction}")
    else
       issues = current_user.own_issues.order("#{sort_column} #{sort_direction}")
    end
    issues = issues.page(page).per_page(per_page)
    if params[:sSearch].present?
      issues = issues.where("issue_category like :search or title like :search or id like :search", search: "%#{params[:sSearch]}%")
    end
    issues
  end

  def page
    params[:iDisplayStart].to_i/per_page + 1
  end

  def per_page
    params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
  end

  def sort_column
    columns = %w[id issue_category title  description]
    columns[params[:iSortCol_0].to_i]
  end

  def sort_direction
    params[:sSortDir_0] == "desc" ? "desc" : "asc"
  end
end
