# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def request
      Rails.logger.info 'Entering Web::AuthController#request'
    end

    def callback
      Rails.logger.info('Callback reached')
      render plain: 'Callback successful', status: :ok
      auth = request.env['omniauth.auth']

      user = User.find_or_create_by(provider: auth['provider'], uid: auth['uid']) do |u|
        u.email = auth['info']['email']
        u.name = auth['info']['name']
        u.password = SecureRandom.hex(16)
      end

      if user.persisted?
        session[:user_id] = user.id
        redirect_to root_path, notice: 'Вы успешно вошли в систему.'
      else
        redirect_to root_path, alert: 'Не удалось войти в систему.'
      end
    end
  end
end
