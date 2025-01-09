# frozen_string_literal: true

module Web
  class BulletinsController < ApplicationController
    before_action :authenticate_user!, only: %i[new edit update create archive to_moderate]
    before_action :set_bulletin, only: %i[show edit update archive to_moderate]

    # CRUD
    def index
      @bulletins = Bulletin.published.order('created_at desc')
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
        flash.now[:alert] = I18n.t('bulletins.create.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      authorize @bulletin
    end

    # AASM
    def archive
      authorize @bulletin

      if @bulletin.may_archive?
        @bulletin.archive!

        flash.now[:notice] = I18n.t('aasm.bulletin.transitions.archive.success')
      else
        flash.now[:alert] = I18n.t('aasm.bulletin.transitions.archive.failure')
      end
  
      redirect_back fallback_location: profile_path
    end
  
    def to_moderate
      authorize @bulletin

      if @bulletin.may_to_moderate?
        @bulletin.to_moderate!

        flash.now[:notice] = I18n.t('aasm.bulletin.transitions.to_moderate.success')
      else
        flash.now[:alert] = I18n.t('aasm.bulletin.transitions.to_moderate.failure')
      end
  
      redirect_back fallback_location: profile_path
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
