# frozen_string_literal: true

module Admin
  class BulletinsController < ApplicationController
    # TODO: allowed actions
    before_action :set_bulletin, only: %i[index]

    def index
      @bulletins = Bulletin.order('created_at desc')
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image)
    end

    def set_bulletin
      @bulletin = Bulletin.find params[:id]
    end
  end
end
