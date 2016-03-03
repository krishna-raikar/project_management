class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        raise request.env["omniauth.auth"].image.inspect
        @user = User.from_omniauth(request.env["omniauth.auth"])
        sign_in_and_redirect @user
        # raise request.env["omniauth.auth"].inspect
    end

     def google_oauth2
        # raise request.env["omniauth.auth"].info.image.inspect
        @user = User.from_omniauth(request.env["omniauth.auth"])

        # raise @user.inspect
        if Attachment.find_by(attachable_id:@user.id).nil?          
            att = @user.build_attachment() 
            att.update_attributes(remote_file_url:request.env["omniauth.auth"].info.image)
            att.save!
        else
             att = Attachment.find_by(attachable_id:@user.id) 
        end
        sign_in_and_redirect @user
    end
end