# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      user = User.find_or_create_by!(email: auth_hash['info']['email']) do |u|
        u.name = auth_hash['info']['name']
      end

      session[:user_id] = user.id
      redirect_to root_path
    end
  end
end
