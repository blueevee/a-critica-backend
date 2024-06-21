class SessionsController < ApplicationController
    def create
      user = User.find_by(username: params[:username])
      if user&.authenticate(params[:password])
        session[:user_id] = user.id
        render json: { status: 'ok' }
      else
        render json: { error: 'Credenciais inválidas' }, status: :unauthorized
      end
    end

    def destroy
      session[:user_id] = nil
      render json: { status: 'ok' }
    end
  end
