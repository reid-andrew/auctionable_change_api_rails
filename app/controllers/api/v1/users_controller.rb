class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
    if !user.save
      render json: UsersSerializer.new(user), status: :bad_request
    else
      user.save
      render json: UsersSerializer.new(user), status: :created
    end
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
