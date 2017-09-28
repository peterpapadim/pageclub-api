class Api::V1::UsersController < ApplicationController

  skip_before_action :authenticate, only: [:create]

  def index
    user = User.all
    render json: user
  end

  def create
    user_exists = User.find_by(email: user_params[:email].downcase)
    if user_exists
      render json: {error: "User already existed with entered email"}, status: 401
    else
      user = User.create(user_params)
      jwt = Auth.issue({user: user.id})
      render json: {jwt: jwt}
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    render json: @user
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end

end
