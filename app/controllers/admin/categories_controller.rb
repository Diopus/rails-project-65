# frozen_string_literal: true

module Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[edit update destroy]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def edit
    end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_categories_path, notice: I18n.t('categories.create.success')
      else
        flash.now[:alert] = I18n.t('categories.create.error')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @category = Category.find params[:id]
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: I18n.t('categories.update.success')
      else
        flash.now[:alert] = I18n.t('categories.update.error')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @category&.destroy!

      redirect_to admin_categories_path, notice: I18n.t('categories.destroy.success')
    end

    private

    # Only allow a list of trusted parameters through.
    def category_params
      params.require(:category).permit(:name)
    end

    def set_category
      @category = Category.find params[:id]
    end
  end
end
