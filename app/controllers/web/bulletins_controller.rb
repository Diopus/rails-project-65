# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[show edit update destroy]

    def index
      @bulletins = Bulletin.order('created_at desc')
    end

    def show
      @bulletin = Bulletin.find(params[:id])
    end

    def new
      @bulletin = Bulletin.new
    end

    def edit; end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to bulletin_path(@bulletin), notice: I18n.t('bulletins.create.success')
      else
        flash.now[:alert] = I18n.t('bulletins.create.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update; end

    def destroy; end

    private

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :description, :image, :title)
    end

    def set_bulletin
      @bulletin = Bulletin.find params[:id]
    end
  end
end
