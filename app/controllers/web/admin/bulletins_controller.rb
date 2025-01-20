# frozen_string_literal: true

module Web::Admin
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[archive publish reject]

    def index
      @q = Bulletin.order('created_at desc').ransack(params[:q])
      @bulletins = @q.result.page(params[:page]).per(20)
    end

    # AASM
    def archive
      if @bulletin.may_archive?
        @bulletin.archive!

        flash[:notice] = I18n.t('aasm.bulletin.transitions.archive.success')
      else
        flash[:alert] = I18n.t('aasm.bulletin.transitions.archive.failure')
      end

      redirect_back fallback_location: admin_root_path
    end

    def publish
      if @bulletin.may_publish?
        @bulletin.publish!

        flash[:notice] = I18n.t('aasm.bulletin.transitions.publish.success')
      else
        flash[:alert] = I18n.t('aasm.bulletin.transitions.publish.failure')
      end

      redirect_back fallback_location: admin_root_path
    end

    def reject
      if @bulletin.may_reject?
        @bulletin.reject!

        flash[:notice] = I18n.t('aasm.bulletin.transitions.reject.success')
      else
        flash[:alert] = I18n.t('aasm.bulletin.transitions.reject.failure')
      end

      redirect_back fallback_location: admin_root_path
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
