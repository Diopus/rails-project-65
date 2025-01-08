# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_locale

  include Authentication
  include Pundit::Authorization

  helper_method :user_signed_in?, :current_user

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
