class ErrorsController < ApplicationController
 
  def unauth_access
  	render(:status => 401)
  end


   def not_found
    render(:status => 404)
  end

  def internal_server_error
    render(:status => 500)
  end
end
