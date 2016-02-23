class PromaxController < ApplicationController
  
  # before_action :authenticate_user!
   layout "adminportal"


  def index
  	a=current_user.designation
  	if a.eql?("admin")
  		render :layout => 'adminportal'
  	else
  		render :layout => 'userportal'	
  	end	
  	
  end
end
