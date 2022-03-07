class Api::V1::UsersController < ApplicationController
  def create
    user = User.create(user_params)

    if user.save
      show
    elsif (params[:password] != params[:password_confirmation])
      render json: {
        error: "Passwords don't match.",
      },
      status: :unprocessable_entity
    else
      render json: {
        error: "#{user.errors.messages}",
      },
      status: :unprocessable_entity
    end
  end

  def show
    if params[:email].present?
      render json: UserSerializer.new(User.find_by! email: params[:email])
    elsif params[:id].present?
      render json: UserSerializer.new(User.find(params[:id]))
    else
      not_found
    end
  end

  private

  def user_params
    params.permit(:email, :password, :password_confirmation)
  end

  def not_found
    render json: {
      error: 'not found',
    },
    status: :not_found
  end
end
