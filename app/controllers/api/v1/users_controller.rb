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
    render json: {id: user.id, firstName: user.first_name, lastName: user.last_name, email: user.email, memberSince: user.created_at}
  end

  def update
    user = User.find(params[:id])
    updated_first_name = params[:updated_full_name].split.first
    updated_last_name = params[:updated_full_name].split.last
    user.update(first_name: updated_first_name, last_name: updated_last_name)
    render json: {id: user.id, firstName: user.first_name, lastName: user.last_name, email: user.email, memberSince: user.created_at}
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: {}
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :id, :updated_full_name)
  end

end
