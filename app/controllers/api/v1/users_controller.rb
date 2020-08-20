class Api::V1::UsersController < ApplicationController
  def create
    user = User.new(user_params)
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :email, :password, :password_confirmationq)
  end

end
