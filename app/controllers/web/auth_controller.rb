# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      user = find_or_create_user(auth_hash)

      if user.persisted?
        sign_in(user)
        redirect_to root_path, notice: 'Вы успешно вошли в систему.'
      else
        redirect_to root_path, alert: 'Не удалось войти в систему.'
      end
    end

    def logout
      sign_out
      redirect_to root_path, notice: 'Вы успешно вышли из системы.'
    end

    private

    def find_or_create_user(auth_hash)
      User.find_or_create_by!(email: auth_hash['info']['email']) do |u|
        u.name = auth_hash['info']['name']
      end
    end
  end
end
