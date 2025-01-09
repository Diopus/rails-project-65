# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit update create]
    before_action :set_bulletin, only: %i[show edit update]

    def index
      @bulletins = Bulletin.order('created_at desc')
    end

    def show
      authorize @bulletin

      @author_name = @bulletin.user.name

      email = @bulletin.user.email
      @author_email = email[email.index('@')..]
    end

    def new
      @bulletin = Bulletin.new
    end

    def edit
      authorize @bulletin
    end

    def create
      @bulletin = current_user.bulletins.build(bulletin_params)

      if @bulletin.save
        redirect_to bulletin_path(@bulletin), notice: I18n.t('bulletins.create.success')
      else
        flash.now[:alert] = I18n.t('bulletins.create.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @bulletin
    end

    private

    def bulletin_params
      params.require(:bulletin).permit(:category_id, :description, :image, :title)
    end

    def set_bulletin
      @bulletin = Bulletin.find params[:id]
    end
  end
end
