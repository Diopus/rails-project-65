# frozen_string_literal: true

module Admin
  class BulletinsController < ApplicationController
    def index
      @bulletins = Bulletin.order('created_at desc')
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image)
    end
  end
end
