class Api::V1::SessionsController < ApplicationController

  def create
    if User.exists?(email: params[:email])
      user = User.find_by email: params[:email]
      if user.authenticate(params[:password])
        render json: UserSerializer.new(user)
      else
        render json: {
          error: "Invalid credentials.",
        },
        status: :unauthorized
      end
    else
      render json: {
        error: "User not found. Please create an account.",
      },
      status: :not_found
    end
  end
end 
