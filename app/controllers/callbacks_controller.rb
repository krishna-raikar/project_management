class CallbacksController < Devise::OmniauthCallbacksController
    def facebook
        @user=check_exists
        if @user.nil?
            @user = User.from_omniauth(request.env["omniauth.auth"])
            if Attachment.find_by(attachable_id:@user.id).nil?          
                att = @user.build_attachment() 
                att.update_attributes(remote_file_url:request.env["omniauth.auth"].info.image.gsub('http://','https://'))
                att.save!
            else
                 att = Attachment.find_by(attachable_id:@user.id) 
            end
            sign_in_and_redirect @user
        else
            sign_in_and_redirect @user, event: :authentication
        end
    end

     def google_oauth2

        @user=check_exists
        if @user.nil?
            # raise "e".inspect
            @user = User.from_omniauth(request.env["omniauth.auth"])
            if Attachment.find_by(attachable_id:@user.id).nil?          
                att = @user.build_attachment() 
                att.update_attributes(remote_file_url:request.env["omniauth.auth"].info.image)
                att.save!
            else
                 att = Attachment.find_by(attachable_id:@user.id) 
            end
            sign_in_and_redirect @user
        else
            # raise @user.inspect
            sign_in_and_redirect @user, event: :authentication
        end
    end


    def check_exists
         auth=request.env["omniauth.auth"]
         
         @user = User.find_by(email:auth.info.email)
         return @user
    end
end