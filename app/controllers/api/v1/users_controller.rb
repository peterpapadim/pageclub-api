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
    token = request.headers["HTTP_AUTHORIZATION"].split.last
    user_id = Auth.decode(token)
    user = User.find(user_id["user"])
    render json: {id: user.id, firstName: user.first_name, lastName: user.last_name, email: user.email}
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :id)
  end

end
