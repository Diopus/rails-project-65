# frozen_string_literal: true

module Admin
  class BulletinsController < ApplicationController
    before_action :set_bulletin, only: %i[archive publish reject]

    def index
      @bulletins = Bulletin.order('created_at desc')
    end

    # AASM
    def archive
      if @bulletin.may_archive?
        @bulletin.archive!

        flash.now[:notice] = I18n.t('aasm.bulletin.transitions.archive.success')
      else
        flash.now[:alert] = I18n.t('aasm.bulletin.transitions.archive.failure')
      end
  
      redirect_back fallback_location: admin_root_path
    end

    def publish
      if @bulletin.may_publish?
        @bulletin.publish!

        flash.now[:notice] = I18n.t('aasm.bulletin.transitions.publish.success')
      else
        flash.now[:alert] = I18n.t('aasm.bulletin.transitions.publish.failure')
      end
  
      redirect_back fallback_location: admin_root_path
    end
  
    def reject
      if @bulletin.may_reject?
        @bulletin.reject!

        flash.now[:notice] = I18n.t('aasm.bulletin.transitions.reject.success')
      else
        flash.now[:alert] = I18n.t('aasm.bulletin.transitions.reject.failure')
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
