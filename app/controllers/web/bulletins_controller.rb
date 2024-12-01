# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy]

    def index
      @bulletins = Bulletin.all
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new; end

    def edit; end

    def create; end

    def update; end

    def destroy; end

    private

    def bulletin_params
      params.require(:bulletin).permit(:title, :description, :image)
    end

    def set_bulletin
      @bulletin = Bulletin.find params[:id]
    end
  end
end
