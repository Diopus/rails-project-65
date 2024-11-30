# frozen_string_literal: true

module Web
  class AuthController < ApplicationController
    def callback
      auth_hash = request.env['omniauth.auth']
      user = find_or_create_user(auth_hash)

      sign_in(user)
      redirect_to root_path
    end

    private

    def find_or_create_user(auth_hash)
      User.find_or_create_by!(email: auth_hash['info']['email']) do |u|
        u.name = auth_hash['info']['name']
      end
    end
  end
end
