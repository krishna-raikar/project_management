class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
      # user ||= User.new # guest user (not logged in)
      #  # raise user.inspect
      # if user.designation=="admin"
      #   can :manage, :all
      # elsif user.designation=="employee"
      #   val = ["view","edit"]
      #   val.each do |v|
      #     pro = "project"
      #     can v.to_sym, pro.capitalize.constantize
      #   end 
      #   # can [:view,:edit], Project
      # end
     
      arr = Role.all
      arr.each do |u|
        if user.designation.eql?(u.name)
            rec = Permission.where(role_id:u.id)
            # raise rec.inspect
            rec.each do |r|
              r.per_list.each do |p|
                 if r.modelname.eql?("all")
                   can [p.to_sym], :all
                 else 
                   can [p.to_sym], r.modelname.capitalize.constantize
                 end
                  # can p.to_sym, Project
              end
            end  
        end
      end
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
