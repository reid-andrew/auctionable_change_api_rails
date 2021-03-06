class Api::V1::SessionsController < ApplicationController
  def create
    user = User.find_by(email: session_params[:email])
    if user.present? && user.authenticate(session_params[:password])
      session[:user_id]= user.id
      render json: UsersSerializer.new(user), status: :ok
    elsif !session_params[:email] || !session_params[:password]
      render '/login/fill_fields.json', status: :bad_request
    else
      render '/login/register.json', status: :bad_request
    end
  end

  def destroy
    session.clear
    render '/logout/logged_out.json', status: :ok
  end

  private

  def session_params
    params.permit(:email, :password)
  end
end
