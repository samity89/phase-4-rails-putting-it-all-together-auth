class SessionsController < ApplicationController

    def create
        user = User.find_by(username: params[:username])
        if user
            if user&.authenticate(params[:password])
                session[:user_id] = user.id
                render json: user, status: :created
            else
                render json: { error: "Invalid username or password" }, status: :unauthorized
            end
        else
            user_not_logged_in
        end    
    end

    def destroy
        if session[:user_id] 
            session.delete :user_id
            head :no_content
        else
            user_not_logged_in
        end
    end

    private

    def user_not_logged_in
        user = User.new
        user.validate
        render json: {errors: user.errors.full_messages}, status: 401
    end

end