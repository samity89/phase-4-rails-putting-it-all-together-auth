class RecipesController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_entity_response
    before_action :authorize
    
    def index
        recipes = Recipe.all
        render json: recipes, include: :user, status: 200
    end

    def create
        recipe = Recipe.create!(title: params[:title], instructions: params[:instructions], minutes_to_complete: params[:minutes_to_complete], user_id: session[:user_id])
        render json: recipe, include: :user, status: 201
    end

    private

    def authorize
      user = User.new
      user.validate
      return render json: { errors: user.errors.full_messages }, status: :unauthorized unless session.include? :user_id
    end

    def render_invalid_entity_response(invalid)
      render json: { errors: invalid.record.errors.full_messages }, status: 422
    end

end


