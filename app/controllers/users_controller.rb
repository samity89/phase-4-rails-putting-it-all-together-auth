class UsersController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :user_invalid_response
    
    def create
        user = User.create!(user_params)
        session[:user_id] = user.id
        render json: user, status: 201
    end


    def show
        user = User.find_by(id: session[:user_id])
        if user
        render json: user, status: 200
        else
        render json: {error: "Unauthorized access"}, status: 401
        end
    end

    private

    def user_params
        params.permit(:username, :password, :image_url, :bio, :password_confirmation)
    end

    def user_invalid_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

end
