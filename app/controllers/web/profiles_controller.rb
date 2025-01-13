# frozen_string_literal: true

module Web
  class ProfilesController < ApplicationController
    before_action :authenticate_user!

    def show
      @q = current_user.bulletins.order('created_at desc').ransack(params[:q])
      @bulletins = @q.result.page(params[:page]).per(20)
    end
  end
end
