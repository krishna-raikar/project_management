module TasksHelper
	def assign_to_list
		users = ProjectUser.where(project_id:5).joins(:user).pluck("users.id")
        u = User.where(id:users)
	end
end
