class Ability
  include CanCan::Ability

  def initialize(user,params)
    # Define abilities for the passed in user here. For example:
    #
      user ||= User.new # guest user (not logged in)
       # raise user.inspect
      # if user.role.name=="admin"
      #   can :manage, :all
      # elsif user.role.name=="employee"

      # end
      #   # val = ["view"]
      #   # val.each do |v|
      #     # pro = "project"
      #     # raise params[:id].inspect
      #     # unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?
      #       can :show, Project  unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?
            
      #       can :show, Task  unless Task.find_by(id:params[:id],user_id:user.id,project_id:params[:project_id]).nil?
      #       # raise Task.find_by(id:params[:id],user_id:user.id,project_id:params[:project_id]).nil?.inspect
      #       # can :show,Task
      #       can :show,Issue unless Issue.find_by("id=? and project_id=? and (creator_id=? or assignee_id=?)",params[:id],params[:project_id],user.id,user.id).nil?
            
      #       can [:show,:edit,:destroy],User, :id => user.id

      #       can :manage,ProjectUser unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?
            
      #       # can :manage,Attachment unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?

      #     # end 
      #   # end 
      #   # can [:view,:edit], Project
      # end

      # ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?
      # Task.find_by(id:3,user_id:1,project_id:1).nil?


      # Issue.find_by(id:19,project_id:3,creator_id:1)
      # Issue.find_by("id=19 and project_id=3 and (creator_id=1 or assignee_id=1)")




     # raise user.inspect
      arr = Role.all
      arr.each do |u|
        if user.role.name.eql?(u.name)
            rec = Permission.where(role_id:u.id)
            # raise rec.inspect
            rec.each do |r|
              r.per_list.each do |p|
                 if r.modelname.eql?("all")
                   can [p.to_sym], :all
                 else
                   if r.modelname.eql?("project") and !p.eql?("create") 
                      if u.name.eql?("manager")

                        can [:show_emp],r.modelname.capitalize.constantize
                        can [p.to_sym], r.modelname.capitalize.constantize    
                      else
                        if params[:id]
                          can [p.to_sym], r.modelname.capitalize.constantize unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:id]).nil?
                        else
                          can [p.to_sym], r.modelname.capitalize.constantize unless ProjectUser.find_by(user_id:user.id).nil?
                        end
                      end
                   elsif r.modelname.eql?("task") and !p.eql?("create") 
                      can [p.to_sym], r.modelname.capitalize.constantize 
                   elsif r.modelname.eql?("issue") and !p.eql?("create") 
                      can [p.to_sym], r.modelname.capitalize.constantize 
                   elsif r.modelname.eql?("user")
                      can [p.to_sym], r.modelname.capitalize.constantize,:id => user.id
                   elsif r.modelname.eql?("project user") 
                     a = r.modelname
                     model = a.split.map(&:capitalize).join(' ').split(' ').map(&:capitalize).join('')
                     
                     can [p.to_sym], model.constantize  unless ProjectUser.find_by(user_id:user.id,:project_id=>params[:project_id]).nil?
                   else   
                      can [p.to_sym], r.modelname.capitalize.constantize
                   end
                 end
                  # can p.to_sym, Project
              end
            end  
        end
      end

#unless Task.find_by(id:params[:id],user_id:user.id,project_id:params[:project_id]).nil?
#unless Issue.find_by("id=? and project_id=? and (creator_id=? or assignee_id=?)",params[:id],params[:project_id],user.id,user.id).nil?

    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
