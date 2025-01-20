# frozen_string_literal: true

module Web::Admin
  class CategoriesController < ApplicationController
    before_action :set_category, only: %i[edit update destroy]

    def index
      @categories = Category.all
    end

    def new
      @category = Category.new
    end

    def edit; end

    def create
      @category = Category.new(category_params)

      if @category.save
        redirect_to admin_categories_path, notice: I18n.t('categories.crud.create.success')
      else
        flash[:alert] = I18n.t('categories.crud.create.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def update
      @category = Category.find params[:id]
      if @category.update(category_params)
        redirect_to admin_categories_path, notice: I18n.t('categories.crud.update.success')
      else
        flash[:alert] = I18n.t('categories.crud.update.failure')
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      if @category.bulletins.present?
        flash[:warning] = I18n.t('categories.crud.destroy.has_bulletins')
      else
        @category.destroy
        flash[:notice] = I18n.t('categories.crud.destroy.success')
      end

      redirect_back(fallback_location: admin_categories_path)
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
