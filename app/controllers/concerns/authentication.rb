# frozen_string_literal: true

module Authentication
  def current_user
    @current_user ||= session[:user_id] && User.find_by(id: session[:user_id])
  end

  def sign_in(user)
    session[:user_id] = user.id
  end

  def sign_out
    session.delete(:user_id)
    @current_user = nil
  end

  def user_signed_in?
    current_user.present?
  end
end
