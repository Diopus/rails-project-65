# frozen_string_literal: true

class BulletinPolicy < ApplicationPolicy
  attr_reader :user, :bulletin

  # rubocop:disable Lint/MissingSuper
  def initialize(user, bulletin)
    @user = user
    @bulletin = bulletin
  end
  # rubocop:enable Lint/MissingSuper

  # CRUD
  def show?
    bulletin&.published? || author? || admin?
  end

  def edit?
    author?
  end

  def update?
    edit?
  end

  # AASM
  def archive?
    author?
  end

  def to_moderate?
    author?
  end

  private

  def admin?
    user&.admin?
  end

  def author?
    user && bulletin.user == user
  end
end
