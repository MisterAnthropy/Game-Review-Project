class SessionsController < ApplicationController

    def create
       @user = User.find_by(username: params[:user][:username])
        
       if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id 
        redirect_to user_path(@user)
       else
        flash[:error] = "Incorrect, please try again."
        redirect_to login_path
       end
    end

    def destroy
        session.delete(:user_id)
        redirect_to '/'
    end

    def omniauth
        @user = User.create_by_google_oauth2(auth)
        session[:user_id] = @user.id
        redirect_to user_path(@user)
    end

    private

        def auth
            request.env['omniauth.auth']
        end

end
