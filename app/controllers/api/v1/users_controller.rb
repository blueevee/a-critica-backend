class Api::V1::UsersController < ApplicationController
  before_action :authenticate_user, only: [:create]

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      render json: {'msg': 'Usuário criado - ' + user.username}, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: {'msg': 'Login bem-sucedido - ' + user.username}, status: :ok
    else
      render json: { error: 'Crendenciais inválidas' }, status: :unauthorized
    end
  end

  def logout
    session[:user_id] = nil
    render json: {'msg': 'Logout bem-sucedido'}, status: :ok
  end

  private

  def user_params
    params.permit(:username, :password)
  end

  def authenticate_user
    unless session[:user_id]
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end
