# frozen_string_literal: true

class Web::BulletinsController < ApplicationController
  # TODO: allowed actions
  before_action :set_bulletin, only: %i[index]

  def index
    @bulletins = Bulletin.all
  end

  private

  def bulletin_params
    params.require(:bulletin).permit(:title, :description, :image)
  end

  def set_bulletin
    @bulletin = Bulletin.find params[:id]
  end
end
